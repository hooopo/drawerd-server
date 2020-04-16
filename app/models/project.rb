# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id                              :bigint           not null, primary key
#  adapter(postgresql,mysql,mssql) :string           default("postgresql"), not null
#  import_sql_data                 :jsonb
#  name                            :string
#  relation_csv_data               :jsonb
#  share_key                       :string
#  table_csv_data                  :jsonb
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  company_id                      :bigint
#  user_id                         :bigint
#
# Indexes
#
#  index_projects_on_company_id  (company_id)
#  index_projects_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#

class Project < ApplicationRecord
  enum adapter: %w[postgresql mysql mssql].map { |name| [name, name] }.to_h
  validates :name, presence: true
  belongs_to :user
  belongs_to :company, touch: true
  has_many :tables
  has_many :relationships
  has_many :groups
  include FileUploader::Attachment(:table_csv)
  include FileUploader::Attachment(:relation_csv)

  before_create do
    self.share_key = SecureRandom.hex(15)
  end

  after_create do
    if table_csv.present?
      csv = table_csv.download.read
      CSV.parse(csv, headers: true).each do |row|
        table = self.tables.create_with(comment: row['table_comment']).find_or_create_by(schema: row['table_schema'], name: row['table_name'])
        next if table.new_record?
        column = table.columns.create_with(
          column_type: row['column_type'], 
          nullable: row['is_nullable'], 
          is_pk: !!row['primary_key'],
          comment: row['column_comment']
        ).find_or_create_by(name: row['column_name'])
      end
    end

    if relation_csv.present?
      csv = relation_csv.download.read
      CSV.parse(csv, headers: true).each do |row|
        table = self.tables.where(name: row['table'], schema: row['schema']).first
        column = table.columns.where(name: row['column']).first

        relation_table = self.tables.where(name: row['relation_table'], schema: row['relation_table_schema']).first
        relation_column = relation_table.columns.where(name: row['relation_column']).first

        self.relationships.create(
          table: table,
          column: column,
          relation_table: relation_table,
          relation_column: relation_column
        )
      end
    end
  end

  def node_attributes(table, mode)
    base = {}
    base = base.merge(label: table.to_html(mode))
    base = base.merge(shape: :box) if mode == :simple
    base = base.merge(shape: :plaintext) if mode == :full
    base = base.merge(color: "#01f800") if mode == :simple
    base = base.merge(style: :filled) if mode == :simple
    base = base.merge(href: "javascript:window.parent.edit_table('#{Rails.application.routes.url_helpers.edit_project_table_path(self, table)}');")
    base
  end

  def edge_attributes(rel)
    base = {}
    base = base.merge(dir: :both) if rel.m2m?
    base = base.merge(style: :dashed) if rel.virtual?
    base = base.merge(href: "javascript:window.parent.edit_relationship('#{Rails.application.routes.url_helpers.edit_project_relationship_path(self, rel)}');")
    base = base.merge(label: rel.relation_type)
    base
  end

  def to_graph(mode: :full, layout: :dot, group_id: nil)
    #  "dot", "neato", "twopi", "fdp", "circo"
    layout = %w[dot fdp circo].map { |item| [item, item.to_sym]  }.to_h[layout] || :dot
    mode = %w[simple full].map { |item| [item, item.to_sym]  }.to_h[mode] || :full
    graph = GraphViz.new(name, rankdir: "LR", bgcolor: "#F7F8F9", use: layout, compound: true)
    graph.edge["lhead"] = ""
    graph.edge["ltail"] = ""

    base_tables = if group_id.present?
      tables.where(group_id: group_id)
    else
      tables
    end
    table2nodes = {}
    base_tables.group_by { |t| t.group }.each do |group, tables|
      if group
        sub_graph = graph.add_graph("cluster#{group.id}", rankdir: "LR", bgcolor: "#F7F8F9", compound: true)
        sub_graph[:label] = group.name
        sub_graph[:style] = :dashed
        tables.each do |table|
          table_node = sub_graph.add_nodes(
            table.id.to_s,
            node_attributes(table, mode)
          )
          table2nodes[table.id] = table_node
        end
      else
        tables.each do |table|
          table_node = graph.add_nodes(
            table.id.to_s,
            node_attributes(table, mode)
          )
          table2nodes[table.id] = table_node
        end
      end
    end


    relationships.each do |rel|
      next unless table2nodes[rel.table_id] && table2nodes[rel.relation_table_id]
      graph.add_edges(
        table2nodes[rel.table_id],
        table2nodes[rel.relation_table_id],
        edge_attributes(rel)
      )
    end
    graph
  end

  def render_graph(mode: :full, layout: :dot, group_id: nil)
    graph = to_graph(mode: mode, layout: layout, group_id: group_id)
    path = Rails.root.join("tmp", "#{id}.svg")
    graph.output(svg: path)
    File.read(path)
  end
end

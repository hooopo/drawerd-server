# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id                              :bigint           not null, primary key
#  adapter(postgresql,mysql,mssql) :string           default("postgresql"), not null
#  arrow_color                     :string
#  auto_draw                       :boolean          default(FALSE)
#  bg_color                        :string
#  export_foreign_key              :boolean          default(TRUE)
#  import_sql_data                 :jsonb
#  name                            :string
#  relation_csv_data               :jsonb
#  share_key                       :string
#  table_body_color                :string
#  table_csv_data                  :jsonb
#  table_header_color              :string
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
require "csv"
require "tsv_detector"

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

  DEFAULT_TABLE_HEADER_COLOR = "#ececfc"
  DEFAULT_BG_COLOR           = "#F7F8F9"
  DEFAULT_TABLE_BODY_COLOR   = "#01f800"
  DEFAULT_ARROW_COLOR        = "#000000"

  before_create do
    self.share_key = SecureRandom.hex(15)
  end

  def table_header_color_with_default
    table_header_color.presence || DEFAULT_TABLE_HEADER_COLOR
  end

  def table_body_color_with_default
    table_body_color.presence || DEFAULT_TABLE_BODY_COLOR
  end

  def bg_color_with_default
    bg_color.presence || DEFAULT_BG_COLOR
  end

  def arrow_color_with_default
    arrow_color.presence || DEFAULT_ARROW_COLOR
  end

  validates_format_of :bg_color,
    with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/,
    allow_blank: true,
    message: "Accept Hex color"
  validates_format_of :table_header_color,
    with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/,
    allow_blank: true,
    message: "Accept Hex color"
  validates_format_of :table_body_color,
    with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/,
    allow_blank: true,
    message: "Accept Hex color"
  validates_format_of :arrow_color,
    with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/,
    allow_blank: true,
    message: "Accept Hex color"

  after_create do
    if table_csv.present?
      csv = table_csv.download.read
      if TsvDetector.new(csv).tsv?
        opt = { headers: true }.merge(col_sep: "\t", quote_char: nil, liberal_parsing: true)
      else
        opt = { headers: true }
      end
      CSV.parse(csv, **opt).each do |row|
        table = self.tables.create_with(comment: row["table_comment"]).find_or_create_by(schema: row["table_schema"], name: row["table_name"])
        next if table.new_record?
        column = table.columns.create_with(
          column_type: row["column_type"],
          nullable: row["is_nullable"],
          is_pk: row["primary_key"],
          comment: row["column_comment"]
        ).find_or_create_by(name: row["column_name"])
      end
    end

    if relation_csv.present?
      csv = relation_csv.download.read
      if TsvDetector.new(csv).tsv?
        opt = { headers: true }.merge(col_sep: "\t", quote_char: nil, liberal_parsing: true)
      else
        opt = { headers: true }
      end
      CSV.parse(csv, **opt).each do |row|
        table = self.tables.where(name: row["table"], schema: row["schema"]).first
        column = table.columns.where(name: row["column"]).first

        relation_table = self.tables.where(name: row["relation_table"], schema: row["relation_table_schema"]).first
        relation_column = relation_table.columns.where(name: row["relation_column"]).first

        self.relationships.create(
          table: table,
          column: column,
          relation_table: relation_table,
          relation_column: relation_column,
          relation_type: row["relation_type"] || "many"
        )
      end
    else
      if auto_draw
        Column.joins(table: :project).where(projects: { id: self.id }).each do |relation_column|
          if single_table_name = relation_column.name[/^([a-zA-Z0-9_]+)_id$/, 1]
            table = self.tables.where(name: single_table_name.pluralize).first
            column = table.columns.where(name: "id").first if table
            self.relationships.create(
              table: table,
              column: column,
              relation_table: relation_column.table,
              relation_column: relation_column
            ) if table && column
          end
        end
      end
    end
  end

  def node_attributes(table, mode)
    base = {}
    base = base.merge(label: table.to_html(mode))
    base = base.merge(shape: :box) if mode == :simple
    base = base.merge(shape: :plaintext) if mode == :full || mode == :accurate
    base = base.merge(color: table_body_color_with_default) if mode == :simple
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
    base = base.merge(color: arrow_color_with_default)
    base
  end

  def to_graph(mode: :full, layout: :dot, group_id: nil)
    #  "dot", "neato", "twopi", "fdp", "circo"
    layout = %w[dot fdp circo].map { |item| [item, item.to_sym]  }.to_h[layout] || :dot
    mode = %w[simple full accurate].map { |item| [item, item.to_sym]  }.to_h[mode] || :full
    graph = GraphViz.new(name, rankdir: "LR", bgcolor: bg_color_with_default, use: layout, compound: true)
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
        sub_graph = graph.add_graph("cluster#{group.id}", rankdir: "LR", bgcolor: group.color_with_default, compound: true)
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
      if rel.column_id && layout == :dot && mode == :accurate
        from = { table2nodes[rel.table_id] => "right#{rel.column_id}" }
      else
        from = table2nodes[rel.table_id]
      end

      if rel.relation_column_id && layout == :dot && mode == :accurate
        to = { table2nodes[rel.relation_table_id] => "left#{rel.relation_column_id}" }
      else
        to = table2nodes[rel.relation_table_id]
      end
      graph.add_edges(
        from,
        to,
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

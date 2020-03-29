# == Schema Information
#
# Table name: projects
#
#  id                              :bigint           not null, primary key
#  adapter(postgresql,mysql,mssql) :string           default("postgresql"), not null
#  name                            :string
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
  belongs_to :company
  has_many :tables
  has_many :relationships
  has_many :groups

  def to_graph
    graph = GraphViz.new(name, rankdir: 'LR', size: '5,50', bgcolor: "#80FF80")
    table2nodes = {}
    tables.each do |table|
      table_node = graph.add_nodes(table.id.to_s, label: "<<b>#{table.name}</b>>", shape: :box, style: :filled, href: "javascript:alert(#{table.id})")
      table2nodes[table.id] = table_node
    end
    graph.add_nodes("struct1", "label" => '<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">
  <TR>
    <TD colspan="3"><b>users</b></TD>
  </TR>
  <TR>
    <TD>left</TD>
    <TD PORT="f1">mid dle</TD>
    <TD PORT="f2">right</TD>
  </TR>
</TABLE>>', shape: :plaintext)

    relationships.each do |rel|
      graph.add_edges(table2nodes[rel.table_id], table2nodes[rel.relation_table_id], label: rel.relation_type, href: "javascript:alert(#{rel.id})")
    end
    graph
  end

  def render_graph
    graph = to_graph
    path = Rails.root.join("tmp", "#{id}.svg")
    graph.output(svg: path)
    File.read(path)
  end
end

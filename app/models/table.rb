# frozen_string_literal: true

# == Schema Information
#
# Table name: tables
#
#  id                              :bigint           not null, primary key
#  comment                         :string
#  name                            :string
#  schema                          :string           default("public")
#  table_type(table or view or mv) :string           default("table")
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  group_id                        :bigint
#  project_id                      :bigint
#
# Indexes
#
#  index_tables_on_group_id    (group_id)
#  index_tables_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (project_id => projects.id)
#

class Table < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :project
  has_many :columns, dependent: :destroy, inverse_of: :table
  has_many :relationships, dependent: :destroy

  validates :name, uniqueness: { scope: :project_id }
  validates :name, presence: true
  accepts_nested_attributes_for :columns, reject_if: :all_blank, allow_destroy: true

  def self.import_from_ddl_parser(project, parsed_table)
    this_table = project.tables.create(name: parsed_table.name, comment: parsed_table.comment)
    parsed_table.columns.each do |column|
      this_table.columns.create(name: column.name, comment: column.comment, column_type: column.column_type)
    end
    this_table
  end

  def to_html(mode = :full)
    <<~HTML
      <<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">
        <TR>
          <TD bgcolor='#ececfc' ALIGN="CENTER" colspan="3"><b>#{display_name}</b></TD>
        </TR>
        #{column_html if mode == :full }
       </TABLE>>
    HTML
  end

  def column_html
    columns.map do |c|
      c.to_html
    end.join("\n")
  end

  def display_name
    output = if schema == "public"
      name
    else
      [schema, name].join(".")
    end
    [output, comment.presence].compact.join("/")
  end
end

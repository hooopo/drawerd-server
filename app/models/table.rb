# == Schema Information
#
# Table name: tables
#
#  id                              :bigint           not null, primary key
#  comment                         :string
#  name                            :string
#  primary_keys                    :bigint           default([]), is an Array
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
  has_many :columns, dependent: :destroy
  has_many :relationships, dependent: :destroy

  def to_html
    <<~HTML
      <<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">
        <TR>
          <TD bgcolor='#ececfc' ALIGN="CENTER" colspan="3"><b>#{display_name}</b></TD>
        </TR>
        #{column_html }
       </TABLE>>
    HTML
  end

  def column_html
    columns.map do |c|
      c.to_html
    end.join("\n")
  end

  def display_name
    if schema == 'public'
      name
    else
      [schema, name].join(".")
    end
  end
end

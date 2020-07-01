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
  belongs_to :project, touch: true
  has_many :columns, dependent: :destroy, inverse_of: :table
  has_many :relationships, dependent: :destroy

  validates :name, uniqueness: { scope: :project_id }
  validates :name, presence: true
  accepts_nested_attributes_for :columns, reject_if: :all_blank, allow_destroy: true

  def to_html(mode = :full)
    if mode == :full || mode == :accurate
      <<~HTML
        <<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">
          <TR>
            <TD bgcolor='#{project.table_header_color_with_default}' ALIGN="CENTER" colspan="3"><b>#{display_name}</b></TD>
          </TR>
          #{column_html}
         </TABLE>>
      HTML
    else
      display_name(mode)
    end
  end

  def column_html
    columns.to_a.sort_by { |x| [x.sort, x.id] }.map do |c|
      c.to_html
    end.join("\n")
  end

  def to_dbml_option
    "note: #{comment.inspect}" if comment.present?
  end

  def display_name(mode = :full)
    output = if schema == "public"
      name
    else
      [schema, name].join(".")
    end
    if mode == :simple
      [output, comment.presence].compact.join("\n")
    else
      [output, comment.presence].compact.join("<br />")
    end
  end
end

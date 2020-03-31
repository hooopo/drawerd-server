# == Schema Information
#
# Table name: columns
#
#  id          :bigint           not null, primary key
#  column_type :string           default("string")
#  comment     :string
#  name        :string
#  nullable    :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  table_id    :bigint
#
# Indexes
#
#  index_columns_on_table_id  (table_id)
#
# Foreign Keys
#
#  fk_rails_...  (table_id => tables.id)
#

class Column < ApplicationRecord
  belongs_to :table

  TYPES = [
    :string,
    :text,
    :integer,
    :float,
    :decimal,
    :datetime,
    :timestamp,
    :time,
    :date,
    :binary,
    :blob,
    :boolean,
    :json
  ]

  def to_html
    <<~HTML
      <TR>
        <TD bgcolor='green' ALIGN="LEFT">#{name}</TD>
        <TD bgcolor='green' >#{column_type}</TD>
        <TD bgcolor='green' ALIGN="RIGHT">[null, pk]</TD>
      </TR>
    HTML
  end
end

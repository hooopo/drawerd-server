# frozen_string_literal: true

# == Schema Information
#
# Table name: columns
#
#  id          :bigint           not null, primary key
#  column_type :string           default("string")
#  comment     :string
#  is_pk       :boolean          default(FALSE)
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
        <TD bgcolor='green' ALIGN="RIGHT">#{ext_info}</TD>
      </TR>
    HTML
  end

  def ext_info
    null = if nullable
      "null"
    else
      "not null"
    end
    pk = if is_pk
      "pk"
    end

    "[#{[null, pk].compact.join(", ")}]"
  end
end

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
  belongs_to :table, touch: true

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
        <TD port="left#{self.id}" bgcolor='#01f800' ALIGN="LEFT">#{name}</TD>
        <TD bgcolor='#01f800' ALIGN="LEFT">#{column_type}</TD>
        <TD port="right#{self.id}" bgcolor='#01f800' ALIGN="RIGHT">#{ext_info}</TD>
      </TR>
    HTML
  end

  def to_dbml_option
    opt = []
    opt << "pk" if is_pk
    opt << "not null" if not nullable
    opt << "note: #{comment.inspect}" if comment.present?
    if opt.present?
      "[#{opt.join(", ")}]"
    else
      ""
    end
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

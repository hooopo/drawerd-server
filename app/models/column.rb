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
  has_many :relationships, foreign_key: :relation_column_id

  TYPES = {
    postgresql: [
      "integer",
      "bigint",
      "varchar",
      "text",
      "float",
      "decimal",
      "timestamp",
      "time",
      "date",
      "uuid",
      "json",
      "jsonb",
      "daterange",
      "numrange",
      "int[]",
      "bigint[]",
      "text[]",
      "varchar[]",
      "float[]",
      "date[]",
      "uuid[]",
      "json[]",
      "jsonb[]",
      "tsrange",
      "tstzrange",
      "int4range",
      "int8range",
      "bytea",
      "boolean",
      "xml",
      "tsvector",
      "hstore",
      "inet",
      "cidr",
      "macaddr",
      "ltree",
      "citext",
      "point",
      "line",
      "lseg",
      "box",
      "path",
      "polygon",
      "circle",
      "bit",
      "money",
      "interval"
    ],
    mysql: [
      "int",
      "bigint",
      "tinyint",
      "smallint",
      "mediumint",
      "varchar",
      "text",
      "tinytext",
      "mediumtext",
      "longtext",
      "char",
      "varchar",
      "float",
      "double",
      "decimal",
      "datetime",
      "timestamp",
      "time",
      "date",
      "blob",
      "json"
    ],
    mssql: [
      "int",
      "bigint",
      "bit",
      "decimal",
      "money",
      "smallmoney",
      "float",
      "real",
      "date",
      "datetime",
      "datetime2",
      "datetimeoffset",
      "smalldatetime",
      "datetime",
      "time",
      "char",
      "varchar",
      "text",
      "nchar",
      "nvarchar",
      "ntext",
      "binary",
      "varbinary",
      "timestamp"
    ]
  }

  def to_html
    <<~HTML
      <TR>
        <TD port="left#{self.id}" bgcolor='#{table.project.table_body_color_with_default}' ALIGN="LEFT">#{name}</TD>
        <TD bgcolor='#{table.project.table_body_color_with_default}' ALIGN="LEFT">#{column_type}</TD>
        <TD port="right#{self.id}" bgcolor='#{table.project.table_body_color_with_default}' ALIGN="RIGHT">#{ext_info}</TD>
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

  def doc_desc
    [table.name, name].join(".")
  end

  def ext_doc_info
    null = if !nullable
      "Not Null"
    end

    pk = if is_pk
      "PK"
    end
    [pk, null].compact.map { |info| %Q|<span class="badge badge-info">#{info}</span>| }.join(" ")
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

# frozen_string_literal: true

class MdGenerator
  attr_reader :project
  def initialize(project)
    @project = project
  end

  def to_md
    buffer = "".dup
    buffer << "# #{project.name}\n\n"
    project.tables.order("id asc").each do |table|
      buffer << "## #{table.name}\n\n"
      buffer << "#{table.comment}\n\n"
      MDTable.convert([%w[name column_type ext_info ref default comment], *table.columns.order("sort asc, id asc").map do |column|
        [
          column.name,
          column.column_type,
          column.ext_info,
          column.relationships.map { |rel| "[#{rel.column&.doc_desc}](##{rel.table&.name})" }.join(", "),
          column.default_value,
          column.comment
        ]
      end]).each do |line|
        buffer << line
        buffer << "\n"
      end
      buffer << "\n"
    end
    buffer
  end
end

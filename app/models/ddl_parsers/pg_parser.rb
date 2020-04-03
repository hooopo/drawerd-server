# frozen_string_literal: true

module DdlParsers
  class PgParser < DdlParser
    attr_reader :parser

    def initialize(ddl)
      super
      @parser = PgQuery.parse(ddl)
    rescue PgQuery::ParseError
      @parser = PgQuery.parse("")
    end

    def tables
      parser.parsetree.map { |x| x["CREATESTMT"] }.compact.map do |x|
        table_name = x.dig("relation", "RANGEVAR", "relname")
        columns = x.dig("tableElts").reverse.map do |column|
          column_name = column.dig("COLUMNDEF", "colname")
          Result::Column.new(
            name: column.dig("COLUMNDEF", "colname"),
            column_type:  column.dig("COLUMNDEF", "typeName", "TYPENAME", "names")[-1],
            comment: comments.find { |comment| comment.id == [table_name, column_name].join(".") }&.comment
          )
        end
        Result::Table.new(
          name: table_name,
          columns: columns,
          comment: comments.find { |comment| comment.id == table_name }&.comment
        )
      end
    end

    def comments
      @comments ||= parser.parsetree.map { |x| x["COMMENTSTMT"] }.compact.map do |x|
        next if x.dig("object").is_a?(Hash)
        comment_id = x.dig("object").map { |y| y.dig("STRING", "str") }.join(".")
        Result::Comment.new(comment: x.dig("comment"), id: comment_id)
      end.compact
    end
  end
end

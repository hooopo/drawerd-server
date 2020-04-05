# frozen_string_literal: true

module DdlParsers
  module Result
    class Relationship < Dry::Struct
      attribute :table, Types::String
      attribute :column, Types::String
      attribute :relation_table, Types::String
      attribute :relation_column, Types::String
    end
  end
end

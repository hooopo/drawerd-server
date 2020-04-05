# frozen_string_literal: true

module DdlParsers
  module Result
    class Column < Dry::Struct
      attribute :name, Types::String
      attribute :comment, Types::String.optional
      attribute :column_type, Types::String
      attribute :is_pk, Types::Bool
    end
  end
end

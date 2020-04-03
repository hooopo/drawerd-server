module DdlParsers
  module Result
    class Table < Dry::Struct
      attribute :name, Types::String
      attribute :columns, Types::Strict::Array.of(Column)
      attribute :comment, Types::String.optional
    end
  end
end
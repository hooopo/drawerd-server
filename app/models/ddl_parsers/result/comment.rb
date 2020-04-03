module DdlParsers
  module Result
    class Comment < Dry::Struct
      attribute :id, Types::String
      attribute :comment, Types::String
    end
  end
end
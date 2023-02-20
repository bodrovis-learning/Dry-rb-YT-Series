# frozen_string_literal: true

require 'dry-struct'

module Lotr
  class Character < Dry::Struct
    attribute :id, Types::Strict::String
    attribute :name, Types::Strict::String
    attribute :age, Types::Age
    attribute :height?, Types::Coercible::Float.optional
  end
end

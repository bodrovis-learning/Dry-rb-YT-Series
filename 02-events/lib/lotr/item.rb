# frozen_string_literal: true

require 'dry-struct'
require 'time'

module Lotr
  class Item < Dry::Struct
    attribute :id, Types::ItemId
    attribute :owner, Character
    attribute :description, Types::String.fallback('[EMPTY]')
    attribute :price, Types::Coercible::Float
    attribute(:found_at, Types::JSON::Time.default { Time.now })
    attribute :locked, Types::Params::Bool.default(false)
    attribute :quality, Types::Symbol.default(:common).enum(:common, :uncommon, :rare, :unique)
    attribute :weight?, Types::Strict::String | Types::Strict::Integer
    attribute :inscription?, Types::Strict::String.optional
    attribute :state?, Types::String.enum('good' => 0, 'damaged' => 1, 'broken' => 2)
    attribute :prev_owners?, Types::Hash.map(Types::String, Types::Integer)
    attribute :dmg?, Types.Instance(Range)
    attribute :tags?, Types::Array.of(Types::Coercible::String)
  end
end

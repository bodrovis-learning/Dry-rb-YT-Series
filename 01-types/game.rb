# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'
require 'time'

module Types
  include Dry.Types()

  Age = Integer.constrained(gteq: 0)
  # id-12345
  ItemId = String.constrained(format: /\Aid-\d{2,5}\z/i)
end

class Character < Dry::Struct
  attribute :name, Types::Strict::String
  attribute :age, Types::Age
  attribute :height, Types::Coercible::Float
end

bilbo = Character.new name: 'Bilbo', age: 50, height: '120.5'
aragorn = Character.new name: 'Aragorn', age: 73, height: 185

puts bilbo.inspect
puts bilbo.name
puts aragorn.inspect

# char_hash = Types::Hash.schema(
#   name: Types::Strict::String,
#   age: Types::Strict::Integer.
#     default(18).
#     constructor { |v|
#       v.nil? ? Dry::Types::Undefined : v
#     }
#   ).strict.with_key_transform(&:to_sym)

# puts char_hash["name" => "Bilbo", age: 20].inspect

class Item < Dry::Struct
  attribute :owner, Character
  attribute :description, Types::String.fallback('[EMPTY]')
  attribute :inscription, Types::Strict::String.optional
  attribute :price, Types::Coercible::Float
  attribute :found_at, Types::JSON::Time.default { Time.now }
  attribute :locked, Types::Params::Bool
  attribute :weight, Types::Strict::String | Types::Strict::Integer
  attribute :id, Types::ItemId
  attribute :quality, Types::Symbol.default(:common).enum(:common, :uncommon, :rare, :unique)
  attribute :state?, Types::String.enum('good' => 0, 'damaged' => 1, 'broken' => 2)
  # {OWNER_NAME => YEAR}
  attribute :prev_owners?, Types::Hash.map(Types::String, Types::Integer)
  attribute :dmg?, Types.Instance(Range)
  attribute :tags?, Types::Array.of(Types::Coercible::String)
end

narsil = Item.new owner: aragorn,
                  description: 10,
                  inscription: 'For the Dunedain!',
                  price: '10000.50',
                  found_at: '1567-11-26 12:00:00',
                  locked: true,
                  weight: '2kg',
                  id: 'id-123',
                  quality: :rare,
                  state: 'broken', # 2
                  dmg: (100..150),
                  tags: %i[sword dunedain magical]

ring = Item.new owner: bilbo,
                description: 'The One Ring',
                inscription: nil,
                price: 100_000_00.50,
                locked: 'true',
                weight: 100,
                id: 'id-345',
                quality: :unique,
                prev_owners: { 'Sauron' => 500, 'Gollum' => 1000 },
                tags: %w[ring golden]

puts '=' * 50
puts narsil.inspect
puts "\nOwner of Narsil: #{narsil.owner.name}\n"
puts ring.inspect

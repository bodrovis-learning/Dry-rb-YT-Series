# frozen_string_literal: true

require 'zeitwerk'
require 'dry/monads'

loader = Zeitwerk::Loader.for_gem
loader.setup

module Lotr
  extend Dry::Monads[:result, :do]

  class << self
    def add_item_for_char(item_id, char_id, do_fail = false)
      item = yield Lotr::Model::Item.find_by_id(item_id)
      char = yield Lotr::Model::Character.find_by_id(char_id, do_fail)

      puts "Adding item for char ID #{char.id}"

      Success(id: rand(0..1000))
      # char.bind {|c| puts c.id}
      # puts char.failure?
      # puts char.failure
      
      # char.bind do |c|
      #   item.bind do |i|
      #     puts c.inspect
      #     puts i.inspect
      #     puts "Adding item for char ID #{c.id}"
      #     Success(id: rand(0..1000))
      #     # rand(0..1000)
      #   end
      # end
    end
  end
end

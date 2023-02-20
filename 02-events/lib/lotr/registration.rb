# frozen_string_literal: true

require 'digest'
require 'dry/events/publisher'

module Lotr
  class Registration
    include Dry::Events::Publisher[:my_publisher]

    register_event('character.created') # => on_character_created
    register_event('character.removed')

    attr_reader :characters

    def initialize
      @characters = {}
    end

    def add_character(name, age, height = nil)
      id = Digest::SHA1.hexdigest("#{name}-#{age}")[8..16]

      character = Character.new id: id, name: name, age: age, height: height

      puts 'Adding character...'

      sleep 1

      @characters[id] = character

      publish 'character.created', character: character

      id
    end

    def remove_character(id)
      character = @characters[id]

      @characters.delete id

      publish('character.removed', character: character)
    end
  end
end

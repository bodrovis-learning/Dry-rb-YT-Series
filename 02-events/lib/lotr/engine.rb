# frozen_string_literal: true

module Lotr
  class Engine
    attr_reader :registration

    def initialize
      @registration = Registration.new

      listener = Listener.new

      @registration.subscribe listener
      # @registration.subscribe 'character.created' do |event|
      #   puts event.inspect
      #   puts event[:character].name
      # end
      # .unsubscribe(NAME)
    end
  end
end

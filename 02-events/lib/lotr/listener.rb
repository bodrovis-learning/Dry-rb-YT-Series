# frozen_string_literal: true

module Lotr
  class Listener
    def initialize
      @log = File.new 'log.txt', 'a+'
    end
    # on_EVENT_NAME

    def on_character_created(event)
      puts event.inspect

      @log.write "\nCharacter added: #{event[:character].inspect}\n"
    end

    def on_character_removed(event)
      puts event.inspect

      @log.write "\nCharacter removed: #{event[:character].inspect}\n"
    end
  end
end

# frozen_string_literal: true

require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module Lotr
  class << self
    def start
      @engine = Engine.new
    end

    def add_character(name, age, height = nil)
      @engine.registration.add_character(name, age, height)
    end

    def remove_character(id)
      @engine.registration.remove_character id
    end
  end
end

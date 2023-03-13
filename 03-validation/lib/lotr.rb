# frozen_string_literal: true

require 'zeitwerk'
require 'dry/types'
require 'dry/validation'

loader = Zeitwerk::Loader.for_gem
loader.setup

module Lotr
  class << self
    def start
      @engine = Engine.new
    end

    def add_character(params)
      @engine.registration.add_character params
    end
  end
end

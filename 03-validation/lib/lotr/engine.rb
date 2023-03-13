# frozen_string_literal: true

module Lotr
  class Engine
    attr_reader :registration

    def initialize
      @registration = Registration.new
    end
  end
end

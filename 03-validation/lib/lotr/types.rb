# frozen_string_literal: true

module Lotr
  module Types
    include Dry::Types()

    StrippedString = Types::String.constructor(&:strip)
  end
end

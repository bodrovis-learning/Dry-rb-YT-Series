module Lotr
  module Model
    class Base
      extend Dry::Monads[:maybe, :result]

      attr_reader :id

      def initialize(id)
        @id = id
      end

      class << self
        def find_by_id(id, do_fail = false) # => образец класса, либо что-то вроде nil
          # do_fail ? nil : self.new(id)
          #do_fail ? None() : Some(self.new(id))
          do_fail ? Failure(:not_found) : Success(self.new(id))
        end
      end
    end
  end
end
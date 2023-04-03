module Lotr
  module Model
    class Item < Base
      def price
        rand(0..1000)
      end
    end
  end
end
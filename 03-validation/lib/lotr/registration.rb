# frozen_string_literal: true


module Lotr
  class CustomValidator
    def valid?(values)
      puts 'CUSTOM VALIDATOR!'
      puts values.inspect
      true
    end
  end

  class Registration
    def add_character(params)
      result = Contracts::CharacterContract.new(
        custom_validator: CustomValidator.new
      ).call(params)

      puts result.inspect

      if result.success?
        # ... add char to the db
      end

      result
    end
  end
end

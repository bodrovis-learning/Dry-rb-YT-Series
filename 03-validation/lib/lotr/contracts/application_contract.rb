# frozen_string_literal: true

module Lotr
  module Contracts
    class ApplicationContract < Dry::Validation::Contract
      config.messages.default_locale = :ru
      config.messages.load_paths << "#{Dir.getwd}/lib/config/errors.yml"

      register_macro(:email_format) do
        key.failure(:invalid_format) unless /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i.match?(value)
      end
    end
  end
end

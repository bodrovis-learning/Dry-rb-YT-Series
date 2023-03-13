# frozen_string_literal: true

module Lotr
  module Contracts
    CharSchema = Dry::Schema.Params do
      required(:name).value(Types::StrippedString)
      required(:age).value(:integer)
      required(:first_page_appear).value(:integer)
      required(:last_page_appear).value(:integer)
      required(:email).filled(:string)
      optional(:height).value(:integer)
      optional(:items).array(:string)
      optional(:relatives).value(:array, min_size?: 1).each do
        hash do
          required(:name).filled(:string)
          required(:relation).filled(:string)
        end
      end
    end

    class CharacterContract < ApplicationContract
      option :custom_validator
      # schema do
      # json do
      # params do
      #   required(:name).value(:string)
      #   required(:age).value(:integer)
      # end

      params(CharSchema)

      rule(:age) do
        key.failure('too low!') if value < 18
      end

      rule(:first_page_appear, :last_page_appear) do
        key(:last_page_appear).failure(:invalid) if values[:last_page_appear] < values[:first_page_appear]
      end

      rule(:height) do
        key.failure('wrong!') if key?(:height) && value < 30
      end

      rule(:email).validate(:email_format)

      rule(:items).each do
        key.failure('is not valid') unless value.start_with?('I-')
      end

      rule(:relatives).each do |index:|
        unless %w[brother sister].include?(value[:relation])
          key([:relatives, :relation, index]).failure('invalid relation')
        end
      end

      rule do
        base.failure('base fail') unless custom_validator.valid?(values) # if rule_error?(:age) # base_rule_error?
      end
    end
  end
end

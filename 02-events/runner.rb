# frozen_string_literal: true

require_relative 'lib/lotr'

Lotr.start
id = Lotr.add_character 'Bilbo', 50


Lotr.remove_character id

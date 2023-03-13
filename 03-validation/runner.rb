# frozen_string_literal: true

require_relative 'lib/lotr'

Lotr.start

r = Lotr.add_character name: '  Bilbo   ',
                       age: '1',
                       last_page_appear: 1,
                       first_page_appear: 100,
                       height: 1,
                       email: '123123',
                       items: %w[I-sword ring],
                       relatives: [
                         { name: 'Rosey', relation: 'sister' },
                         { name: 'Bob', relation: 'uncle' }
                       ]
# :relatives=>{:relation=>{1=>["invalid relation"]}
# :items=>{1=>["is not valid"]}

if r.errors.any?
  puts r.errors.inspect
  puts r.errors.messages
  puts r.errors.to_h
end

puts r.to_h

require_relative 'lib/lotr'
require 'dry/monads'

include Dry::Monads[:maybe, :result, :try]

item = Lotr::Model::Item.find_by_id(44).value_or(nil)

price_result = Try[NoMethodError] { item.price }.fmap { |p| p * 1.1 }
puts price_result

case price_result
in Try::Value
  puts price_result.value!
in Try::Error
  puts price_result.exception
else
  puts 'unknown'
end

# item = Lotr::Model::Item.find_by_id(42, true)

# puts item.inspect

# puts Maybe(item).maybe(&:id).value_or("not found") # => Some, None
# res = Lotr.add_item_for_char 100, 42#, true
# #puts res.inspect
# puts res.or("failed")
# puts(res.trace) if res.failure?

# # puts case res
# # when Success then 'added!'
# # when Failure(:not_found) then 'not found'
# # else
# #   "unknown error"
# # end

# final = case res
# in Success(id: Integer => result)
#   "Result: #{result}"
# in Success
#   'added'
# in Failure[:not_found] => r
#   "Not found, in: #{r.trace}"
# else
#   'unknown error'
# end

# puts final
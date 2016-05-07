require_relative 'action'

i = Action.new

puts "starting get_value_types"
i.get_data("value_types")

puts "starting get_target_value"
i.get_data("target_values")

puts "end of process"


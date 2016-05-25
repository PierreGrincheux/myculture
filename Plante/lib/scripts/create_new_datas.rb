puts ""
puts "#### Creating new values ####"
puts ""

data_card_id = 2
base_value = 25

puts "data_card_id = #{data_card_id}"
puts "base_value = #{base_value}"

vt = ValueType.all
vt.each_with_index do |v,index|
	puts "ValueType = #{v.name}"
	for i in 1..50 do 
		rand_value = rand(10)
		rand(2) == 1 ? rand_value = rand_value : rand_value = rand_value * -1
		new_value = base_value + rand_value
		i = Value.new(
				value_type_id: v.id,
				data_card_id: data_card_id,
				created_at: (Time.now + (i * 12).hours + v.id.to_i.minutes),
				value: new_value
		)
		i.save

		puts "New value created : id = #{i.id}, created_at = #{i.created_at}, value = #{i.value}"
	end
end

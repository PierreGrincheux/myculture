require_relative "action"
require_relative "setup_script"

action = Action.new

puts "running action.setup and action.get_data(value_types)"
action.setup
action.get_data("value_types")

while true do
		thread1 = Thread.new{
				puts "thread1 at #{Time.now}"
				action.get_data("target_values")
				sleep(30)
		}
		sleep(5)

#		thread3 = Thread.new{
#				puts "thread3 at #{Time.now}"
#				action.take_picture
#				sleep(60)
#
#		}
#		sleep(5)

		thread4 = Thread.new{
				puts "thread4 at #{Time.now}"
				while action.get_values_from_data_card != "DONE" do
				end
				action.post_new_values
				action.set_system_response
				puts "ok"
				sleep(20)
		}.join
		puts "thread4 exited"
end

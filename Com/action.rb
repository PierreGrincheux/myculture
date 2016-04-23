class Action 
	require 'nokogiri'
	require_relative "http_connection"
	require_relative "database_connection"

	@@target_url = "http://127.0.0.1:3000/tests/"
	@@greenhouse_id = "2"

	def initialize
	end

	def get_target_values
		f = File.open("log/get_target_values.log","a")

		f.puts ""
		f.puts "#################################################"
		f.puts ""
		
		f.puts "Starting 'get_target_values' method at #{Time.now}"

		hash_params = {request_type: "get_target_value", greenhouse_id: @@greenhouse_id}
		xml_file_path = "xml_target_values/target_values_#{Time.now.strftime("%Y-%m-%d_%H-%M")}.txt"
		processed_file_path = "target_values/target_values_#{Time.now.strftime("%Y-%m-%d_%H-%M")}.txt"
		to_save = ['value-type-id','value']

		#Requête HTTP
			HttpConnection.new(@@target_url,xml_file_path,hash_params)
			f.puts "HTTP request done"

		#XML parsing
		f.puts 'Starting XML parsing'

		doc = Nokogiri::XML(File.open(xml_file_path))
		
		to_save.each do |v|
			array_to_assign = Array.new
			doc.xpath("//#{v}").to_s.split(/[<>]/).each_with_index do |y,index|
				unless index == 0 || index % 2 != 0 
					array_to_assign << y if y != ""
				end
			end
			instance_variable_set("@#{v.gsub('-','_')}", array_to_assign)
		end
		f.puts "Opening data file"
		target_file = File.open(processed_file_path,"w")
		
		#write the top columns names
		to_save.each_with_index do |v, index|
			target_file.write("#{v.gsub('-','_')}")
			index == (to_save.count - 1) ? target_file.write("\n") : target_file.write('!!!')
		end
		
		#Write the values
		for i in 0..(instance_variable_get("@#{to_save[0].gsub('-','_')}").count - 1)
			to_save.each_with_index do |v,index|
				target_file.write("#{instance_variable_get("@#{v.gsub('-','_')}")[i]}")
				index == (to_save.count - 1) ? target_file.write("\n") : target_file.write('!!!')
			end
		end

		target_file.close
		f.puts "Data file closed"

		f.puts 'END OF PROCESS'
		f.close
	end

	def post_new_values

	end
end

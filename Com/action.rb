class Action 
	require 'nokogiri'
	require 'sqlite3'
	require_relative "http_connection"
	require_relative "constants"

	
	def initialize
	end

	def setup
		Dir.mkdir('files_xml') unless File.directory?('files_xml')
		Dir.mkdir('files_processed') unless File.directory?('files_processed')
	end

	
	def get_data(type)
		f = File.open('log/supervision.log','a')

		f.puts ""
		f.puts "#################################################"
		f.puts ""

		f.puts "STARTING 'get_datas' for #{type} at #{Time.now}"

		case type
			when "value_types"
				hash_params = {request_type: "get_value_types", greenhouse_serial_nbr: GREENHOUSE_SERIAL_NBR}
				xml_file_path = "files_xml/value_types.txt"
				processed_file_path = "files_processed/value_types.txt"
				to_save = ['id','name']

			when "target_values"
				hash_params = {request_type: "get_target_value", greenhouse_serial_nbr: GREENHOUSE_SERIAL_NBR}
				xml_file_path = "files_xml/target_values.txt"
				processed_file_path = "files_processed/target_values.txt"
				to_save = ['value-type-id','value']
			end

		#### Requête HTTP ####
		HttpConnection.new(TARGET_URL,xml_file_path,hash_params)
		f.puts "Request sent"

		#### XML parsing ####
		f.puts "Starting to parse XML file"
		doc = Nokogiri::XML(File.open(xml_file_path))

		to_save.each do |v|
			array_to_assign = Array.new
			doc.xpath("//#{v}").to_s.split(/[<>]/).each_with_index do |y,index|
				unless index == 0 || index % 2 != 0
					array_to_assign << y if y != ""
				end
			end
			instance_variable_set("@#{v.gsub('-','_')}",array_to_assign)
		end

		f.puts "Opening data_file"
		
		target_file = File.open(processed_file_path,"w")

		#Write the top columns names
 		to_save.each_with_index do |v,index|
			target_file.write("#{v.gsub('-','_')}")
			index == (to_save.count - 1) ? target_file.write("\n") : target_file.write("!!!")
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

		f.puts ""
		f.puts ""

		file = File.open(processed_file_path,"r")
		
		f.puts "Starting importing new datas for #{type} at #{Time.now}"

		array_values = Array.new
		i=0

		file.each_with_index do |line,index|
			next if index == 0
			array_values << line.split('!!!').map(&:strip)
		end

		f.puts "New datas => #{array_values}"

		begin
			db = SQLite3::Database.open DB_NAME
			f.puts "Database opened"
			db.transaction
			
			send(type,db,array_values,f)	

			db.commit
			f.puts "Data added successfully"

		rescue SQLite3::Exception => e
			puts "ERROR OCCURED"
			puts e
			f.puts "ERROR OCCURED => #{e}"
			db.rollback
		ensure
			f.close if f
		end
	end


	#############################################################
	################## PREVIOUS METHOD PARTIALS #################
	#############################################################

	def value_types(db,array_values,f)
		array_values.each do |v|
			f.puts "Values => #{v.join(', ')}"

			begin
				cc_value_type_id = db.execute "SELECT rowid FROM value_type WHERE name = '#{v[1]}'"
				f.puts "cc_value_type_id = #{cc_value_type_id}"

				cc_old_value_type_id = db.execute "SELECT rowid FROM value_type WHERE rowid = #{cc_value_type_id[0][0]}"
				f.puts "Found - #{cc_old_value_type_id}"
			rescue
				cc_old_value_type_id = []
				f.puts "Not found"
			end

			if cc_old_value_type_id[0] == nil || cc_old_value_type_id[0][0] == nil
				req = db.prepare "INSERT INTO value_type (name, main_db_id) VALUES (?,?)"
				req .execute v[1].to_s, v[0].to_i
				req.close
				f.puts "Inserted - value = #{v[1]}"
			else
				req = db.prepare "UPDATE value_type SET main_db_id = ? WHERE rowid = ?"
				req.execute v[0].to_s, cc_value_type_id[0][0].to_i
				f.puts "Updated - value = #{v[1]}"
			end
		end
	end


	def target_values(db,array_values,f)
		array_values.each do |v|
			f.puts "Values => #{v.join(', ')}"

			begin
				cc_value_type_id = db.execute "SELECT rowid FROM value_type WHERE main_db_id = #{v[0]}"
				cc_old_target_value_id = db.execute "SELECT rowid FROM target_value WHERE value_type_id = #{cc_value_type_id[0][0]}"
				f.puts "Found - #{cc_old_target_value_id}"
			rescue
				cc_old_taarget_value_id = []
				f.puts "Not found"
			end

			if cc_old_target_value_id[0] == nil || cc_old_target_value_id[0][0] == nil
				req = db.prepare "INSERT INTO target_value (value, value_type_id) VALUES (?,?)"
				req.execute v[1].to_f, cc_value_type_id[0][0]
				req.close
				f.puts "Inserted - value = #{v[1]}"				
			else
				req = db.prepare "UPDATE target_value SET value = ? WHERE rowid = ?"
				req.execute v[1].to_f, cc_old_target_value_id[0][0]
				req.close
				f.puts "Updated - value = #{v[1]}"
			end
		end
	end

	###########################################################
	###########################################################
	###########################################################

	def post_new_values
		f = File.open("log/supervision.log", "a")

		f.puts ""
		f.puts "#######################################"
		f.puts ""

		f.puts "Starting 'post_new_values' method at #{Time.now}"

		hash_params = {request_type: "post_new_values", greenhouse_serial_nbr: GREENHOUSE_SERIAL_NBR }

		array_values = parse_csv_file("new_values","!!!")
		f.puts "csv file parsed ; array returned : #{array_values}"

		array_values.each do |v|
			v.each do |t|
				#v[1] = value_type_id ; v[2] = value ; v[3] = created_at
					
					f.puts "Looking for value type name in db"
					db = SQLite3::Database.open @@db_name
						value_type_name = db.execute "SELECT name FROM value_type WHERE rowid = #{v[0]}"
					db.close

					hash_params[:"#{value_type_name[0][0]}_value"] = v[1].to_f
					hash_params[:"#{value_type_name[0][0]}_created_at"] = v[2]
					hash_params[:"#{value_type_name[0][0]}_dc_serial_nbr"] = v[3]

			end
		end
		
		f.puts "SENDING VALUES"
		HttpConnection.new(@@target_url,"",hash_params)
		f.puts "HTTP CONNECTION DONE"

		f.close
	end

	private

	def parse_csv_file(type,delimiter)
		all_files = Dir.entries(type)
		namefile = all_files.drop(2).sort.reverse[0]
		file_to_parse = File.open("#{type}/#{namefile}","r")
		array_values = Array.new

		file_to_parse.each_with_index do |v,index|
			next if index == 0 
			array_values << v.strip.split(delimiter)	
		end

		return array_values
	end
end

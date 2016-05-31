require 'sqlite3'
require_relative 'constants'
require_relative 'action'

Dir.mkdir('log') unless File.directory?('log')

f = File.open("log/supervision.log",'a')
f.puts ""
f.puts "#####################################################"
f.puts ""
f.puts "Starting setup at #{Time.now}"

puts "starting creating db"
###################################
###### CREATING THE DATABASE ######
###################################

#Opening the DB
begin
	begin
		db = SQLite3::Database.new "test2.db"
		f.puts "database created"
	rescue
		db = SQLite3::Database.open "test2.db"
		f.puts "database opened"
	end
	
	#Start transaction
	db.transaction

		########## Drop tables if exists ############

		#TARGET_VALUE
		db.execute "DROP TABLE IF EXISTS target_value"
		#VALUE_TYPE
		db.execute "DROP TABLE IF EXISTS value_type"
		#VALUE
		db.execute "DROP TABLE IF EXISTS value"
		#DATA_CARD
		db.execute "DROP TABLE IF EXISTS data_card"

		f.puts "after dropping all tables if exists"

		########## Create tables if necessary #############

		#TARGET_VALUE
		db.execute "CREATE TABLE target_value (
				value FLOAT,
				value_type_id INT
			);"
		f.puts "after target_value table creation"	
		
		#VALUE_TYPE
		db.execute "CREATE TABLE value_type (
				name VARCHAR(20),
				main_db_id INT
			);"
		f.puts "after value_type table creation"

		#VALUE
		db.execute "CREATE TABLE value (
			value FLOAT,
			created_at TIMESTAMP,
			value_type_id INT, 
			data_card_id INT
			);"
		f.puts "after value table created"

		#DATA_CARD
		db.execute "CREATE TABLE IF NOT EXISTS data_card (
			serial_nbr VARCHAR(20) 
			);"	
		########### END OF TABLE CREATION ###############

		########### ADDING DATA CARDS ###########
		DATA_CARD_SERIAL_NBR.each do |v|
			req = db.prepare "INSERT INTO data_card (serial_nbr) VALUES (?);"
			req.execute v.to_s
			req.close
		end

	#Close transaction
	db.commit

rescue SQLite3::Exception => e
	puts 'ERROR OCCURED'
	puts e
	db.rollback
ensure
	db.close if db
end

##################################
#### #### #### #### #### #### ####
##################################

action = Action.new

##### Preparing different folders
puts "setup"
action.setup
#
##### Adding value_types to database
#puts "get value_types"
#action.get_data('value_types')
#
##### Adding target_values to database
#puts "get target_values"
#action.get_data('target_values')

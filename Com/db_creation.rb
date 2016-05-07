require 'sqlite3'
require_relative 'constants'

#Opening the DB
begin
	begin
		db = SQLite3::Database.new "test2.db"
		puts "database created"
	rescue
		db = SQLite3::Database.open "test2.db"
		puts "database opened"
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

		puts "after dropping all tables if exists"

		########## Create tables if necessary #############

		#TARGET_VALUE
		db.execute "CREATE TABLE target_value (
				value FLOAT,
				value_type_id INT
			);"
		puts "after target_value table creation"	
		
		#VALUE_TYPE
		db.execute "CREATE TABLE value_type (
				name VARCHAR(20),
				main_db_id INT
			);"
		puts "after value_type table creation"

		#VALUE
		db.execute "CREATE TABLE value (
			value FLOAT,
			created_at TIMESTAMP,
			value_type_id INT, 
			data_card_id INT
			);"
		puts "after value table created"

		#DATA_CARD
		db.execute "CREATE TABLE IF NOT EXISTS data_card (
			serial_nbr INT
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


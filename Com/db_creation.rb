require 'sqlite3'

#Opening the DB
begin
	begin
		db = SQLite3::Database.new "test1.db"
		puts "database created"
	rescue
		db = SQLite3::Database.open "test1.db"
		puts "database opened"
	end
	
	
	#Create tables if necessary
	db.execute "CREATE TABLE IF NOT EXISTS target_value (
			value int,
			value_type_id int
		);"
	puts "after target_value table creation"	
	
	db.execute "CREATE TABLE IF NOT EXISTS value_type (
			name varchar(20),
			main_db_id int
		);"
		puts "after value_type table creation"
	
	#Insert value types
	vt_to_insert = {"temperature" => 5,
									"air_humidity" => 6,
									"soil_humidity" => 7,
									"illumination" => 8}
	
	vt_to_insert.each do |pair|
		db.execute "INSERT INTO value_type VALUES (?,?)", pair
	end
	puts "ValueType values added"
	
	v_to_insert = {25 => 5, 
								 50 => 6, 
								 20 => 7, 
								 150 => 8}
	
	v_to_insert.each do |pair|
		db.execute "INSERT INTO value VALUES (?,?)", pair
	end
rescue SQLite3::Exception => e
	puts 'ERROR OCCURED'
	puts e
ensure
	db.close if db
end


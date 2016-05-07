require 'sqlite3'
puts "########"
puts "STARTIND DB_SEEDS SCRIPT"

begin
	#Opening the DB
	db = SQLite3::Database.open "test2.db"
	puts "database opened"
	###############

	db.transaction

	#INSERT VALUE TYPES
	vt_to_insert = {"temperature" => 5,
									"air_humidity" => 6,
									"soil_humidity" => 7,
									"illumination" => 8}
	
	vt_to_insert.each do |pair|
		db.execute "INSERT INTO value_type VALUES (?,?)", pair
	end
	puts "ValueType values added"
	
	#INSERT DATA CARD
	dc_to_insert = ['SN00000001','SN00000002']
	dc_to_insert.each do |v|
		db.execute "INSERT INTO data_card VALUES (?)", v
	end
	puts "DataCard values added"

	#INSERT TARGET VALUE
	tv_to_insert = {25 => 1, 
								 50 => 2, 
								 20 => 3, 
								 150 => 4}
	
	tv_to_insert.each do |pair|
		db.execute "INSERT INTO target_value VALUES (?,?)", pair
	end
	puts "TargetValue values added"

	db.commit

rescue SQLite3::Exception => e
	puts "ERROR OCCURED"
	puts e
	db.rollback
ensure
	db.close if db
end

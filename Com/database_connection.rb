class DatabaseConnection

	require 'mysql2'

	def initialize
		begin
			#con =	Mysql.new('127.0.0.1','test_user1','test_user1','test_serre')
			con = 'It works bitches'
		rescue
			#con = nil
			con = 'It doesn\'t work :('
		end

		return con
	end

	def to_s
		return "toto"
	end
end

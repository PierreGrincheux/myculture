class HttpConnection2
	require "typhoeus"

	def initialize
		puts "Starting HTTP CONNECTION 2"
		res = Typhoeus.get(DATA_CARD_URL)
		File.open(VALUE_FILE_PATH,"w"){ |file| file.write(rres.body)}
		puts "END NEW VALUES PROCESSING"		
	end
end


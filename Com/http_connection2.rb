class HttpConnection2
	require "typhoeus"

	def initialize
		f = File.open('log/supervision.log','a')
		begin
		f.puts "Starting HTTP CONNECTION 2"
		res = Typhoeus.get(DATA_CARD_URL)
		File.open(VALUE_FILE_PATH,"w"){ |file| file.write(res.body)}
		f.puts "END NEW VALUES PROCESSING"		
		rescue => e
			f.puts e.to_s
		end
	end
end


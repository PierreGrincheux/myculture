class HttpConnection
	
	require 'net/http'
	require 'rest-client'
	require 'uri'

	def initialize(url,path_file, hash_params)
		puts "Starting HTTP connection"
		url = "#{url}" 
		uri = URI.parse(url)

		res = Net::HTTP.post_form(uri,hash_params)
		puts "request send"
		unless path_file == ""
			File.open("#{path_file}", 'w') { |file| file.write(res.body) }
			puts "XML file written"
		end
	end
end

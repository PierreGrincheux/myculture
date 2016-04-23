require 'net/http'
require 'uri'

url = 'http://127.0.0.1:3000/'
uri = URI.parse(url)

Net::HTTP.get(uri)

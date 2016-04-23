require 'nokogiri'
require 'net/http'
require 'uri'
require_relative "database_connection"
require_relative "http_connection"

###########################
#### Bloc requête HTTP ####
###########################

#url = 'http://127.0.0.1:3000/tests/'
#uri = URI.parse(url)
#
#to_transfer = {request_type: "get_target_value", greenhouse_id: "2"}
#
#res = Net::HTTP.post_form(uri,to_transfer)
#
#current_time = Time.now
#File.open("xml_target_values/target_values_#{current_time.strftime("%Y-%m-%d_%H-%M")}.txt", 'w') { |file| file.write(res.body) }

hash_params = {request_type: "get_target_value", greenhouse_id: "2"}
HttpConnection.new('http://127.0.0.1:3000/tests/',"xml_target_values/target_values_#{Time.now.strftime("%Y-%m-%d_%H-%M")}.txt",hash_params)

puts 'file written'

###########################
###########################

###########################################
#### Traitement du fichier XML renvoyé ####
###########################################

puts 'starting xml parsing ...'


@doc = Nokogiri::XML(File.open("xml_target_values/target_values_#{Time.now.strftime("%Y-%m-%d_%H-%M")}.txt"))

#Initialisation des variables
values_types = Array.new
values = Array.new

#Récupération des types de valeurs
@doc.xpath("//value-type-id").to_s.split(/[<>]/).each_with_index do |v,index|
	unless index == 0 || index % 2 != 0 
		values_types << v	if v != ""
	end
end

#Récupération des valeurs
@doc.xpath("//value").to_s.split(/[<>]/).each_with_index do |v,index|
	unless index == 0 || index % 2 != 0
		values << v if v != ""
	end
end


target_file = File.open("xml_parsing_test.txt","w")

puts values.join(', ').to_s
puts values_types.join(', ').to_s

target_file.write("value_type!!!value\n")
for i in 0..(values.count - 1)
	target_file.write("#{values_types[i]}!!!#{values[i]}")
	target_file.write("\n")
end

target_file.close

##########################################################
##########################################################

db_con = DatabaseConnection.new
puts db_con.to_s
puts '... xml parsing ended'

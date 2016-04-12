# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

VALUE_TYPES = {
	:temperature => ["Température","degrés","°C"],
	:air_humidity => ["Humidité de l'air","pourcent","%"],
	:soil_humidity => ["Humidité du sol","pourcent","%"],
	:illumination => ["Éclairement","lux","lux"]
}


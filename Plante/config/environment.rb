# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

VALUE_TYPES = {
	:temperature => "Température",
	:air_humidity => "Humidité de l'air",
	:soil_humidity => "Humidité du sol",
	:illumination => "Éclairement"
}


	

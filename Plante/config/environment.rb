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

#Pour le matériel mettre :nom_available ou :nom_disabledd les 2 sont obligatoires et doivent être identiques
HTTP_CONNECTION_TYPES = {
				:get_value_types => ['envoie des types de valeurs','data'],
				:get_target_value => ['envoie des valeurs cibles','data'],
				:post_pictures_available => ['webcam','material'],
				:post_pictures_disabled => ['webcam','material'],
				:fan_available => ['ventilation','material'],
				:fan_disabled => ['ventilation','material'],
				:light_available => ['Éclairage','material'],
				:light_disabled => ['Éclairage','material'],
				:heating_available => ['Chauffage','material'],
				:heating_disabled => ['Chauffage','material']
}

HTTP_CONNECTION_STATES = {
				:available => "Disponible",
				:disabled => "Hors Service"
}

HTTP_CONNECTION_FAMILIES ={
				:data => "Dernier échange de données serre/serveur",
				:material => "État du système"
}

FRENCH_MONTHS = {
"1" => "Janvier",
"2" => "Février",
"3" => "Mars",
"4" => "Avril",
"5" => "Mai",
"6" => "Juin",
"7" => "Juillet",
"8" => "Août",
"9" => "Septembre",
"10" => "Octobre",
"11" => "Novembre",
"12" => "Décembre"
}

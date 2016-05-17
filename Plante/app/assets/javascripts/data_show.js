/*chart*/

/*températur*/
var dataSource = $("#temperature-value").attr("data-source");
var arrayTempValue = dataSource.split("!");
var tempValue = new Array(arrayTempValue[0]); 
for (i = 1; i < arrayTempValue.length; i++){
	//alert(arrayTempValue[i]);
	tempValue.push(parseInt(arrayTempValue[i]));

} 

/*date temp */
var dataSource2 = $("#temperature-date").attr("data-source");
var arrayTempDate = dataSource2.split("!");
var tempDate = new Array(arrayTempDate[0]); 
for (i = 1; i < arrayTempDate.length; i++){
	//alert(typeof(arrayTempDate[i]));
	tempDate.push(Date.parse(arrayTempDate[i]));

} 

/*illumination*/
var dataSource3 = $("#illumination-value").attr("data-source");
var arrayIllumValue = dataSource3.split("!");
var illumValue = new Array(arrayIllumValue[0]); 
for (i = 1; i < arrayIllumValue.length; i++){
	//alert(arrayTempValue[i]);
	illumValue.push(parseInt(arrayIllumValue[i]));

} 

/*soil_humidity*/
var dataSource4 = $("#soil_humidity-value").attr("data-source");
var arraySoilHumValue = dataSource4.split("!");
var soilHumValue = new Array(arraySoilHumValue[0]); 
for (i = 1; i < arraySoilHumValue.length; i++){
	//alert(arrayTempValue[i]);
	soilHumValue.push(parseInt(arraySoilHumValue[i]));

}

/*air_humidity*/ 
var dataSource5 = $("#air_humidity-value").attr("data-source");
var arrayAirHumValue = dataSource5.split("!");
var airHumValue = new Array(arrayAirHumValue[0]); 
for (i = 1; i < arrayAirHumValue.length; i++){
	//alert(arrayTempValue[i]);
	airHumValue.push(parseInt(arrayAirHumValue[i]));

}

//alert(tempValue);
//alert(tempDate);
var chart = c3.generate({
	size: {
	    height: 240,
	    width: 480
	},
	data: {
		x: 'x',
	columns: [tempValue, tempDate, illumValue, soilHumValue, airHumValue]
	},
	axis: {
	 x: {
	   type: 'timeseries',
	   tick: {
	     format: '%Y-%m-%d %H:%M:%S'
	   }
	 },
	},
});
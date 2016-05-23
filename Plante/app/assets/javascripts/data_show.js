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

/*dummy*/ 
var dataSource10 = $("#dummyvalue").attr("data-source");
var arrayDummyValue = dataSource10.split("!");
var dummyValue = new Array(arrayDummyValue[0]); 
for (i = 1; i < arrayDummyValue.length; i++){
	//alert(arrayTempValue[i]);
	dummyValue.push(parseInt(arrayDummyValue[i]));

}

/*xaxis*/ 
var dataSource6 = $("#xaxis").attr("data-source");
var arrayXAxisDate = dataSource6.split("!");
var xAxisDate = new Array(arrayXAxisDate[0]); 
for (i = 1; i < arrayXAxisDate.length; i++){
	//alert(typeof(arrayTempDate[i]));
	xAxisDate.push(Date.parse(arrayXAxisDate[i]));

} 

/*illumination-date*/
var dataSource7 = $("#illumination-date").attr("data-source");
var arrayIlluDate = dataSource7.split("!");
var illuDate = new Array(arrayIlluDate[0]); 
for (i = 1; i < arrayIlluDate.length; i++){
	//alert(typeof(arrayTempDate[i]));
	illuDate.push(Date.parse(arrayIlluDate[i]));

} 

/*soil_humidity-date*/
var dataSource8 = $("#soil_humidity-date").attr("data-source");
var arraySoilHumDate = dataSource8.split("!");
var soilHumDate = new Array(arraySoilHumDate[0]); 
for (i = 1; i < arraySoilHumDate.length; i++){
	//alert(typeof(arrayTempDate[i]));
	soilHumDate.push(Date.parse(arraySoilHumDate[i]));

}

/*air_humidity-date*/
var dataSource9 = $("#air_humidity-date").attr("data-source");
var arrayAirHumDate = dataSource9.split("!");
var airHumDate = new Array(arrayAirHumDate[0]); 
for (i = 1; i < arrayAirHumDate.length; i++){
	//alert(typeof(arrayTempDate[i]));
	airHumDate.push(Date.parse(arrayAirHumDate[i]));

}



//alert(tempDate);
var chart = c3.generate({
	size: {
	    height: 440,
	    width: 1024
	},
	data: {
		   xs: {
	            x: 'xaxis',
				x2: 'Température',
				x3: 'Éclairement',
				x4: 'Humidité du sol',
				x5: 'Humidité de l\'air',
	        },
	columns: [dummyValue, tempValue, tempDate, illumValue, soilHumValue, airHumValue, xAxisDate, illuDate, airHumDate, soilHumDate]
	},
	/*axis: {
	 x: {
	 	type: 'timeseries',
            tick: {
            	format: '%Y-%m-%d %H:%M:%S',

            }

	 
	},
	 x2 : {
        	 	type: 'timeseries',
            tick: {
            	format: "",

            }
    },
     x3 : {
        	 	type: 'timeseries',
            tick: {
            	format: "",

            }
    },
     x4 : {
        	 	type: 'timeseries',
            tick: {
            	format: "",

            }
    },
     x5 : {
        	 	type: 'timeseries',
            tick: {
            	format: "",
   
            }
    },
    },*/
});




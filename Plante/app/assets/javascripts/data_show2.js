/*température*/
var dataSource = $("#temperature-value").attr("data-source");
var arrayTempValue = dataSource.split("!");

var dataSource2 = $("#temperature-date").attr("data-source");
var arrayTempDate = dataSource2.split("!");

var tempData = new Array(); 
for (i = 0; i < arrayTempValue.length; i++){
	tempData.push([Date.parse(arrayTempDate[i]),parseInt(arrayTempValue[i])]);
}

/*éclairement*/
var dataSource3 = $("#illumination-value").attr("data-source");
var arrayIllValue = dataSource3.split("!");

var dataSource4 = $("#illumination-date").attr("data-source");
var arrayIllDate = dataSource4.split("!");

var illData = new Array(); 
for (i = 0; i < arrayIllValue.length; i++){
	illData.push([Date.parse(arrayIllDate[i]),parseInt(arrayIllValue[i])]);
}

/*humidité sol*/
var dataSource5 = $("#soil_humidity-value").attr("data-source");
var arrayHumSoilValue = dataSource5.split("!");

var dataSource6 = $("#soil_humidity-date").attr("data-source"); 
var arrayHumSoilDate = dataSource6.split("!");

var humSoilData = new Array();
for(i = 0; i < arrayHumSoilDate.length; i++){
	humSoilData.push([Date.parse(arrayHumSoilDate[i]),parseInt(arrayHumSoilValue[i])]);
}

/*humidité air*/
var dataSource7 = $("#air_humidity-value").attr("data-source");
var arrayHumAirValue = dataSource7.split("!");

var dataSource8 = $("#air_humidity-date").attr("data-source"); 
var arrayHumAirDate = dataSource8.split("!");

var humAirData = new Array();
for(i = 0; i < arrayHumAirDate.length; i++){
	humAirData.push([Date.parse(arrayHumAirDate[i]),parseInt(arrayHumAirValue[i])]);
}




$(function () {
    $('#chart').highcharts({
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: 'Données réupérées dans la serre'
        },
        subtitle: {
            text: 'Serre X'
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                month: '%e. %b',
                year: '%b'
            },
            title: {
                text: 'Date'
            }
        },




        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value}°C',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            title: {
                text: 'Température',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },

        }, { // Secondary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Éclairement',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            labels: {
                format: '{value} lux',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            }

        }, { // Tertiary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Humidité du sol',
                style: {
                    color: Highcharts.getOptions().colors[2]
                }
            },
            labels: {
                format: '{value}%',
                style: {
                    color: Highcharts.getOptions().colors[2]
                }
            },
            opposite: true
				}, { // 4th yAxis
            gridLineWidth: 0,
            title: {
                text: 'Humidité de l\'air',
                style: {
                    color: Highcharts.getOptions().colors[3]
                }
            },
            labels: {
                format: '{value}%',
                style: {
                    color: Highcharts.getOptions().colors[3]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        
				
				
				legend: {
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },



        series: [{
						name: 'Température',
            type: 'spline',
            data: tempData,
            tooltip: {
                valueSuffix: ' °C'
            }
				}, {
            name: 'Éclairement',
            type: 'spline',
            yAxis: 1,
            data: illData,
            tooltip: {
                valueSuffix: ' lux'
            }
        }, {
						name: 'Humidité du sol',
            type: 'spline',
            yAxis: 2,
            data: humSoilData,
            tooltip: {
                valueSuffix: '%'
            }
        }, {		
            		
            name: 'Humidité de l\'air',
            type: 'spline',
						yaxis: 3,
            data: humAirData,
            tooltip: {
                valueSuffix: '%'
            }
        }]
    });
});
 $( "#dialog" ).hide();
$( ".courbe" ).click(function() {
        $( "#dialog" ).dialog();
    });
 $( ".timelapse" ).click(function() {
        $( "#dialog" ).dialog();
    });





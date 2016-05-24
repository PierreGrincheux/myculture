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

alert(typeof(illData[0]));


$(function () {
    $('#chart').highcharts({
        chart: {
            type: 'spline'
        },
        title: {
            text: 'Données relevées dans la serre ...'
        },
        subtitle: {
            text: '- .... -'
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
        yAxis: {
            title: {
                text: ''
            },
            min: 0
        },
        tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x:%e. %b}: {point.y:.2f} m'
        },

        plotOptions: {
            spline: {
                marker: {
                    enabled: true
                }
            }
        },

        series: [{
            name: 'Température',
            data: tempData
        },{
						name: 'Éclairement',
						data: illData				
				}]
    });
});

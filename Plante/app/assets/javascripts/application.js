// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require snapsvg
//= require fullpage
//= require 'chart.js'
//= require c3
//= require d3
//= require 'greensock/TweenLite'
//= require 'greensock/easing/EasePack'
//= require 'greensock/jquery.gsap.js'
//= require_tree .



$(document).ready(function (){
/*fullpage on home page*/

    $(function(){
      $('#landing .container').fullpage({
        anchors: ['firstPage', 'secondPage', '3rdPage','4thPage','5thPage'],
        navigation: true,
        navigationPosition: 'right',
        navigationTooltips: ['1', '2', '3', '4', '5']
      });
    });



/*chart.js*/
	/*var randomScalingFactor = function () {
	    return Math.round(Math.random() * 100);
	};
	var lineChartData;

	var dataSets = [];

	dataSets[0] = {
	    label: "Line1",
	    strokeColor: "#c84d3f",
	    pointColor: "#c84d3f",
	    pointStrokeColor: "rgba(255,255,255,0)",
	    pointHighlightFill: "#fff",
	    pointHighlightStroke: "#c84d3f",
	    data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()]
	}
	dataSets[1] = {
	    label: "Line2",
	    strokeColor: "#ffd000",
	    pointColor: "#ffd000",
	    pointStrokeColor: "rgba(255,255,255,0)",
	    pointHighlightFill: "#fff",
	    pointHighlightStroke: "#ffd000",
	    data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()]
	}


	lineChartData = {
	    labels: ["01.01.2015", "02.01.2015", "03.01.2015", "04.01.2015", "05.01.2015", "06.01.2015", "07.01.2015"],
	    datasets: dataSets
	}


	var chartOpt = {
	    scaleGridLineColor: "#d1d2d3",
	    datasetFill: false,
	    bezierCurve: false,
	    pointHitDetectionRadius: 10,
	    scaleFontSize: 11,
	    tooltipFillColor: "#273849",
	    tooltipTemplate: function (valuesObject) {
	      	return valuesObject.value + '%'
	    };
	};
	var ctx = document.getElementById("graph1").getContext("2d");
	myNewChart = new Chart(ctx).Line(lineChartData, chartOpt);

	$('input:checkbox').change(function() {
	    var chartId = $(this).attr('data-chart-id');
	    var datasetId = $(this).attr('data-data-set');

	    dataSets[datasetId].hide = !$(this).prop('checked');

	    lineChartData.datasets = [];
	    dataSets.forEach(function (dataset) {
	        var copy = jQuery.extend(true, {}, dataset);
	        if (dataset.hide) copy.data = [];
	        lineChartData.datasets.push(copy);
	    });

	    myNewChart.destroy();
	    myNewChart = new Chart(ctx).Line(lineChartData, chartOpt);
	});*/
var chart = c3.generate({
  bindto: d3.select('.chart'),
  data: {
    columns: [
      ['data1', 30, 200, 100, 400, 150, 250],
      ['data2', 50, 20, 10, 40, 15, 25]
    ]
  }
});



});
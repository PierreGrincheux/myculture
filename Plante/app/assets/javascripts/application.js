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

 /*timeline*/
/*$("#demo").rangeCalendar({
lang: "fr",
theme: "default-theme",
themeContext: this,
startDate: moment(),
endDate: moment().add('months', 12),
start : "+7",
startRangeWidth : 3, 
minRangeWidth: 1,
maxRangeWidth: 14,
weekends: true,
autoHideMonths: false,
visible: true,
trigger: null,
changeRangeCallback : rangeChanged
});*/
$(document).ready(function(){
		
		var callbackRangeCalendar =  $("#cal5").rangeCalendar({changeRangeCallback: rangeChanged,weekends:true,startDate: moment()});
		
		function rangeChanged(target,range){
	    
			
			console.log(range);
		    var startDay = moment(range.start).format('DD');
		    var startMonth = moment(range.start).format('MM');
		    var startYear = moment(range.start).format('YY');
		    var endDay = moment(range.end).format('DD');
		    var endMonth = moment(range.end).format('MM');
		    var endYear = moment(range.end).format('YY');
		    
		    
		    $(".calendar-values .start-date .value").html(startDay + "/" +startMonth);
		    $(".calendar-values .start-date .label").html("");
		    $(".calendar-values .start-date .label").append(startMonth);
		    $(".calendar-values .start-date .label").append("<small>"+ startYear + "</small>");
		    $(".calendar-values .end-date .value").html(endDay + "" + endMonth);
		    $(".calendar-values .end-date .label").html("");
		    $(".calendar-values .end-date .label").append(endMonth );
		    $(".calendar-values .end-date .label").append("<small>"+endYear+"</small>");
		    $(".calendar-values .days-width .value").html(range.width);
		    $(".calendar-values .from-now .label").html(range.fromNow);
		    
		}
    
		function ragneChanged(target,range) {
			
			console.log(range);
		}
    
	});

/*galleria*/

	var id = $("img").attr("data-description");
	alert(id);

    // Initialize Galleria
    $('#galleria').galleria();
    //$('.galleria-stage').prepend('<a class="test" href="#"></a>');
    //$('.galleria-stage').prepend('<div class="info"><div class="galleria-info2 "></div></div>');
    $( ".info" ).hide();

    $( ".test" ).click(function() {
    	$( ".info" ).slideToggle();
	});

});
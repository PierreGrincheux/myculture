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

   /* $(function(){
      $('#landing .container').fullpage({
        anchors: ['firstPage', 'secondPage', '3rdPage','4thPage','5thPage'],
        navigation: true,
        navigationPosition: 'right',
        navigationTooltips: ['1', '2', '3', '4', '5']
      });

    });
*/
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
	//alert(id);

    // Initialize Galleria
    $('#galleria').galleria();
    //$('.galleria-stage').prepend('<a class="test" href="#"></a>');
    //$('.galleria-stage').prepend('<div class="info"><div class="galleria-info2 "></div></div>');
    $( ".info" ).hide();

    $( ".test" ).click(function() {
    	$( ".info" ).slideToggle();
	});

/*animate fullpage */
(function($) {
  
  'use strict';

  // variables
  var $isAnimatedSecond = $('.second .is-animated'),
      $isAnimatedSecondSingle = $('.second .is-animated__single'),
      $isAnimatedThird = $('.third .is-animated'),
      $isAnimatedThirdSingle = $('.third .is-animated__single'),
      $isAnimatedFourth = $('.fourth .is-animated'),
      $isAnimatedFourthSingle = $('.fourth .is-animated__single'),
      $isAnimatedFifth = $('.fifth .is-animated'),
      $isAnimatedFifthSingle = $('.fifth .is-animated__single'),
      $isAnimatedSixth = $('.sixth .is-animated'),
      $isAnimatedSixthSingle = $('.sixth .is-animated__single');


  // initialize fullPage
  $('#fullpage').fullpage({
  	anchors: ['firstPage', 'secondPage', '3rdPage','4thPage','5thPage', '6thPage'],
    navigation: true,
    navigationPosition: 'right',
    navigationTooltips: ['Accueil', 'Présentation', 'Fonctionnalités', 'Design', 'Application Web', 'Contact'],

    onLeave: function(index, nextIndex, direction) {
    
      /**
      * use the following condition: 
      *
      *   if( index == 1 && direction == 'down' ) {
      *
      * if you haven't enabled the dot navigation
      * or you aren't interested in the animations that occur 
      * when you jump (using the dot navigation) 
      * from the first section to another sections 
      */
      
      // first animation
      if( index == 1 && nextIndex == 2 ){ 
      	$isAnimatedSecond.addClass('animated zoomIn').css('animation-delay', '.6s');
        $isAnimatedSecondSingle.addClass('animated lightSpeedIn').css('animation-delay', '1.2s');
        $isAnimatedSecondSingle.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
        $(this).removeClass('lightSpeedIn').addClass('zoomOutDown');
        });
        /*$isAnimatedFourth.addClass('animated fadeInUpBig'); 
        $isAnimatedFourth.eq(0).css('animation-delay', '.3s');
        $isAnimatedFourth.eq(1).css('animation-delay', '.6s');
        $isAnimatedFourth.eq(2).css('animation-delay', '.9s');
        $isAnimatedFourthSingle.addClass('animated rollIn').css('animation-delay', '1.7s');*/
      }

       else if( (index == 1 || index == 2)  && nextIndex == 3 ){ 
        $isAnimatedThird.addClass('animated zoomIn').css('animation-delay', '.6s');
        $isAnimatedThirdSingle.addClass('animated lightSpeedIn').css('animation-delay', '1.2s');
        $isAnimatedThirdSingle.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
        $(this).removeClass('lightSpeedIn').addClass('zoomOutDown');
        });
      }

    /**
      * use the following condition: 
      *
      *   else if( index == 2 && direction == 'down' ) {
      *
      * if you haven't enabled the dot navigation
      * or you aren't interested in the animations that occur 
      * when you jump (using the dot navigation) from the first section to the third one 
      */
      
      // second animation
      else if( ( index == 1 || index == 2 || index == 3 ) && nextIndex == 4 ) {
        $isAnimatedFourth.addClass('animated fadeInUpBig'); 
        $isAnimatedFourth.eq(0).css('animation-delay', '.3s');
        $isAnimatedFourth.eq(1).css('animation-delay', '.6s');
        $isAnimatedFourth.eq(2).css('animation-delay', '.9s');
        $isAnimatedFourthSingle.addClass('animated rollIn').css('animation-delay', '1.7s');
      }

      
     /**
      * use the following condition:
      *
      *   else if( index == 3 && direction == 'down' ) {
      *
      * if you haven't enabled the dot navigation
      * or you aren't interested in the animations that occur 
      * when you jump (using the dot navigation) 
      * from the first or second section to the fourth one 
      */
      
      // third animation
      else if( ( index == 1 || index == 2 || index == 3 || index == 4 ) && nextIndex == 5 ) {
        $isAnimatedFifth.eq(0).addClass('animated fadeInRightBig').css('animation-delay', '.3s'); 
        $isAnimatedFifth.eq(1).addClass('animated fadeInLeftBig').css('animation-delay', '.6s');
        $isAnimatedFifth.eq(2).addClass('animated fadeInUpBig').css('animation-delay', '1.2s');
        $isAnimatedFifthSingle.addClass('animated bounceInDown').css('animation-delay', '1.6s');
      }

      //contact
       else if( ( index == 1 || index == 2 || index == 3 || index == 4 || index == 5) && nextIndex == 6 ) {
        $isAnimatedSixth.addClass('animated fadeInRightBig'); 
        $isAnimatedSixth.eq(0).css('animation-delay', '.3s'); 
        $isAnimatedSixth.eq(1).css('animation-delay', '.6s');
        $isAnimatedSixth.eq(2).css('animation-delay', '.9s');
        $isAnimatedSixth.eq(3).css('animation-delay', '1.2s');
        $isAnimatedSixth.eq(4).css('animation-delay', '1.5s');
        $isAnimatedSixthSingle.addClass('animated bounceInDown').css('animation-delay', '1.6s');
      }


    }

  });
  
})(jQuery);


});
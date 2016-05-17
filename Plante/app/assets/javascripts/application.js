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




});
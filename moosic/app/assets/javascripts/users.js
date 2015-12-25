// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready(function(){
  // Show menu
  $('.user-info-top').on('mouseenter', function(){
      $('.user-menu').show();
  });

  // Hide menu
  $('body').on('click', function(){
      $('.user-menu').hide();
  });
});
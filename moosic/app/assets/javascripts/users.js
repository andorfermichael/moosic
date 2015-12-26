// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready(function() {

  if (window.width >= 768) {
      // Show menu
      $('.user-info-top').on('mouseenter', function() {
          $('.user-menu').show();
      });
  }
  else {
      // Show menu
      $('.user-profile-header').on('mouseenter', function() {
          $('.user-menu').show();
      });
  }

  // Hide menu
  $('body').on('click', function() {
      $('.user-menu').hide();
  });

    // Let flash messages in user profile disappear after specific time period
    window.setTimeout(function() {
        $('#flash_messages.user-profile').fadeOut(1000)
    }, 2500);
});
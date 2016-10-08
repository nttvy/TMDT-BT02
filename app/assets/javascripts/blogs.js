$(document).ready(function() {
  $('.dropdown-toggle').dropdown();

  var max_length = 140;
  var text_length = $('#content-textarea').val().length;
  var text_remaining = max_length - text_length;
  
  $('#character-remaining').html(text_remaining + " character(s) remaining(s)");

  $('#content-textarea').keyup(function() {
    text_length = $(this).val().length;
    text_remaining = max_length - text_length;

    $('#character-remaining').html(text_remaining + " character(s) remaining(s)");
  });
});
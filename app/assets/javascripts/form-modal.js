$(document).on('turbolinks:load', function() {
  $('#narrative-help').on('click', function() {
    $('#narrative-model').modal();
  });
});
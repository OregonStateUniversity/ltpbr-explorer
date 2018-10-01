$(document).on('turbolinks:load', function() {
  $('#affiliation-help').on('click', function() {
    $('#affiliation-model').modal();
  });

  $('#implementation-date-help').on('click', function() {
    $('#implementation-date-model').modal();
  });

  $('#latitude-help').on('click', function() {
    $('#latitude-model').modal();
  });

  $('#longitude-help').on('click', function() {
    $('#longitude-model').modal();
  });

  $('#number-of-structures-help').on('click', function() {
    $('#number-of-structures-model').modal();
  });

  $('#treatment-length-help').on('click', function() {
    $('#treatment-length-model').modal();
  });

  $('#narrative-help').on('click', function() {
    $('#narrative-model').modal();
  });

  $('#primary-contact-help').on('click', function() {
    $('#primary-contact-model').modal();
  });

  $('#structure-description-help').on('click', function() {
    $('#structure-description-model').modal();
  });
});

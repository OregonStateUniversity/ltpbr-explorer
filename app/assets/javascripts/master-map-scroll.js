$(document).on('turbolinks:load', function() {
  $(".static.home").ready(function() {
    $('.btn-map-learn-more').click(function() {
      $('html, body').animate({
        scrollTop: $('.learn-more').offset().top
        }, 1000);
    });
  });
});

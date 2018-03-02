$(".static.home").ready(function() {
  $('.btn-view-map').click(function() {
    $('html, body').animate({
      scrollTop: $('#master-map').offset().top
      }, 1000);
  });

  $('.btn-map-go-back').click(function() {
    $('html, body').animate({
      scrollTop: 0
      }, 1000);
  });
});
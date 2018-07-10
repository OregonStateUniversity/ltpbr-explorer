$(document).on('turbolinks:load', function() {
  $(".projects.show").ready(function() {
    var map_id = $('#map');
    var latitude = map_id.data('latitude');
    var longitude = map_id.data('longitude');
    var zoom = 15;
    var max_zoom = 17;
    var leaflet_map = L.map("map").setView([latitude, longitude], zoom);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoieWJha29zIiwiYSI6ImNqamZmbGh4aTA2MWszcXJtM3phbWlyenoifQ.q9CV0qTFVrReLsKnrj5ALg', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: max_zoom,
      id: 'mapbox.outdoors',
      accessToken: 'pk.eyJ1IjoieWJha29zIiwiYSI6ImNqamZmbGh4aTA2MWszcXJtM3phbWlyenoifQ.q9CV0qTFVrReLsKnrj5ALg'
    }).addTo(leaflet_map);

    var marker = L.marker([latitude, longitude]).addTo(leaflet_map);
  });
});

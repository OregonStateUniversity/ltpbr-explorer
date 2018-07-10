$(document).on('turbolinks:load', function() {
  $(".projects.show").ready(function() {
    var map_id = $('#map');
    var latitude = map_id.data('latitude');
    var longitude = map_id.data('longitude');
    var zoom = 15;
    var max_zoom = 17;
    var leaflet_map = L.map("map").setView([latitude, longitude], zoom);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoic3RydWhzbiIsImEiOiJjamRydHJva3YyZ3huMnhvNDNxYTQ0bzg0In0.2tYsJnemg4TMn-1GnAmc1Q', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: max_zoom,
      id: 'mapbox.outdoors',
      accessToken: 'pk.eyJ1Ijoic3RydWhzbiIsImEiOiJjamRydHJva3YyZ3huMnhvNDNxYTQ0bzg0In0.2tYsJnemg4TMn-1GnAmc1Q'
    }).addTo(leaflet_map);

    var marker = L.marker([latitude, longitude]).addTo(leaflet_map);
  });
});

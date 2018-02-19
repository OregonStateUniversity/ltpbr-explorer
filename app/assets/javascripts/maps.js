$(".projects.show").ready(function() {
  var map = $('#map');
  var latitude = map.data('latitude');
  var longitude = map.data('longitude');
  var mymap = L.map("map").setView([latitude, longitude], 15);
  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoic3RydWhzbiIsImEiOiJjamRydHJva3YyZ3huMnhvNDNxYTQ0bzg0In0.2tYsJnemg4TMn-1GnAmc1Q', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox.outdoors',
    accessToken: 'your.mapbox.access.token'
  }).addTo(mymap);
  var marker = L.marker([latitude, longitude]).addTo(mymap);
});
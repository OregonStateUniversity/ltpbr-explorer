$(document).on('turbolinks:load', function() {
  $(".static.projects_map").ready(function() {
    var projects = gon.projects.projects;
    var map_id = $('#master-map');
    var latitude = map_id.data('latitude');
    var longitude = map_id.data('longitude');

    var zoom = 7;
    var max_zoom = 17;
    var oregon_center_lat = 44.053592;
    var oregon_center_long = -120.379945;
    var leaflet_map = L.map("master-map").setView([oregon_center_lat, oregon_center_long], zoom);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoic3RydWhzbiIsImEiOiJjamRydHJva3YyZ3huMnhvNDNxYTQ0bzg0In0.2tYsJnemg4TMn-1GnAmc1Q', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: max_zoom,
      id: 'mapbox.outdoors',
      accessToken: 'pk.eyJ1Ijoic3RydWhzbiIsImEiOiJjamRydHJva3YyZ3huMnhvNDNxYTQ0bzg0In0.2tYsJnemg4TMn-1GnAmc1Q'
    }).addTo(leaflet_map);

    for (var i = 0; i < projects.length; i++ ) {
      var marker = L.marker([projects[i].latitude, projects[i].longitude]).addTo(leaflet_map);
      marker.bindPopup("<b>Project on "
                        + projects[i].stream_name
                        + "</b><br>Primary Contact: "
                        + projects[i].primary_contact
                        + "<br><a href='/projects/"
                        + projects[i].id
                        + "'>View Project</a>"
                      );
    }
  });
});
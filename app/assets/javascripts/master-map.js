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

    L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
  attribution: 'Tiles &copy; Esri &mdash; and the GIS User Community',
      maxZoom: max_zoom,
      id: 'Esri.WorldTopoMap',
      // accessToken: 'pk.eyJ1IjoieWJha29zIiwiYSI6ImNqamZmbGh4aTA2MWszcXJtM3phbWlyenoifQ.q9CV0qTFVrReLsKnrj5ALg'
    }).addTo(leaflet_map);

    for (var i = 0; i < projects.length; i++ ) {
      var marker = L.marker([projects[i].latitude, projects[i].longitude]).addTo(leaflet_map);
      marker.bindPopup("<b>"
                        + projects[i].name
                        + "</b><br>Stream: "
                        + projects[i].stream_name
                        + "</b><br>Watershed: "
                        + projects[i].watershed
                        + "<br><a href='/projects/"
                        + projects[i].id
                        + "'>View Project</a>"
                      );
    }
  });
});

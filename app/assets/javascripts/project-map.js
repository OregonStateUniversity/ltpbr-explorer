$(document).on('turbolinks:load', function() {
  $(".projects.show").ready(function() {
    var map_id = $('#map');
    var latitude = map_id.data('latitude');
    var longitude = map_id.data('longitude');
    var zoom = 15;
    var max_zoom = 17;
    var leaflet_map = L.map("map").setView([latitude, longitude], zoom);

    L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
      attribution: 'Tiles &copy; Esri &mdash; and the GIS User Community',
      maxZoom: max_zoom,
      id: 'Esri.WorldImagery',
      // accessToken: 'pk.eyJ1IjoieWJha29zIiwiYSI6ImNqamZmbGh4aTA2MWszcXJtM3phbWlyenoifQ.q9CV0qTFVrReLsKnrj5ALg'
    }).addTo(leaflet_map);

    var marker = L.marker([latitude, longitude]).addTo(leaflet_map);
  });
});

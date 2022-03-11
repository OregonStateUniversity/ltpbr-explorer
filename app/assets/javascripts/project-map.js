$(document).on('turbolinks:load', function() {
  var map_id = 'project-map';
  var map_div = $(`#${map_id}`);
  if(map_div.length == 0) {
    return
  }
  
  var latitude = map_div.data('latitude');
  var longitude = map_div.data('longitude');
  var zoom = 15;
  var max_zoom = 17;
  var leaflet_map = L.map(map_id).setView([latitude, longitude], zoom);

  L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
    attribution: 'Tiles &copy; Esri &mdash; and the GIS User Community',
    maxZoom: max_zoom,
    id: 'Esri.WorldImagery',
    // accessToken: 'pk.eyJ1IjoieWJha29zIiwiYSI6ImNqamZmbGh4aTA2MWszcXJtM3phbWlyenoifQ.q9CV0qTFVrReLsKnrj5ALg'
  }).addTo(leaflet_map);

  var marker = L.marker([latitude, longitude]).addTo(leaflet_map);
});

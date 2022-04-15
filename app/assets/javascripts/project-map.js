$(document).on('turbolinks:load', function() {
  const map_id = 'project-map';
  const map_div = $(`#${map_id}`);
  if(map_div.length == 0) {
    return
  }
  
  const latitude = map_div.data('latitude');
  const longitude = map_div.data('longitude');
  const zoom = 15;
  const max_zoom = 17;
  const leaflet_map = L.map(map_id).setView([latitude, longitude], zoom);

  L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
    attribution: 'Tiles &copy; Esri &mdash; and the GIS User Community',
    maxZoom: max_zoom,
    id: 'Esri.WorldImagery',
    // accessToken: 'pk.eyJ1IjoieWJha29zIiwiYSI6ImNqamZmbGh4aTA2MWszcXJtM3phbWlyenoifQ.q9CV0qTFVrReLsKnrj5ALg'
  }).addTo(leaflet_map);

  const marker = L.marker([latitude, longitude]).addTo(leaflet_map);
});

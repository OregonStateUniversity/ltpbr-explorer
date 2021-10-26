$(document).on('turbolinks:load', function() {
  $(".projects.show").ready(function() {
    var map_id = $('#form-map');
    var latitude = map_id.data('latitude');
    var longitude = map_id.data('longitude');
    var zoom = 12;
    var max_zoom = 16;
    var leaflet_map = L.map('form-map').setView([latitude, longitude], zoom);

    L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}', {
      attribution: 'Tiles &copy; Esri &mdash; and the GIS User Community',
      maxZoom: max_zoom,
      id: 'Esri.NatGeoWorldMap',
      // accessToken: 'pk.eyJ1IjoieWJha29zIiwiYSI6ImNqamZmbGh4aTA2MWszcXJtM3phbWlyenoifQ.q9CV0qTFVrReLsKnrj5ALg'
    }).addTo(leaflet_map);

    var marker;

    leaflet_map.on('click', function(e){
      // Remove existing marker
      if(marker) {
        leaflet_map.removeLayer(marker);
      }
      console.log(e.latlng.toString());
      var lat = e.latlng.lat;
      var lng = e.latlng.lng;
      marker = L.marker(e.latlng, {draggable:true}).addTo(leaflet_map);
      //alert("you clicked the map at LAT: "+ lat+" and LONG:"+lng)
    });
  });
});

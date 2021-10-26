$(document).on('turbolinks:load', function() {
  $(".projects.show").ready(function() {
    var project_latitude = document.getElementById('project_latitude');
    var project_longitude = document.getElementById('project_longitude');

    var map_id = $('#form-map');
    var latitude = map_id.data('latitude');
    var longitude = map_id.data('longitude');
    var zoom = 10;
    var max_zoom = 16;
    var leaflet_map = L.map('form-map').setView([latitude, longitude], zoom);

    L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}', {
      attribution: 'Tiles &copy; Esri &mdash; and the GIS User Community',
      maxZoom: max_zoom,
      id: 'Esri.NatGeoWorldMap',
      // accessToken: 'pk.eyJ1IjoieWJha29zIiwiYSI6ImNqamZmbGh4aTA2MWszcXJtM3phbWlyenoifQ.q9CV0qTFVrReLsKnrj5ALg'
    }).addTo(leaflet_map);

    var marker;

    var updateLatlng = latlng => {
      latitude = latlng.lat;
      longitude = latlng.lng;
      project_latitude.value = latitude.toPrecision(8);
      project_longitude.value = longitude.toPrecision(8);
    };

    leaflet_map.on('click', function(e){
      // Remove existing marker
      if(marker) {
        leaflet_map.removeLayer(marker);
      }
      console.log(e.latlng.toString());
      updateLatlng(e.latlng);

      marker = L.marker(e.latlng, {draggable:true}).addTo(leaflet_map);
      marker.on('drag', function(e) {
        updateLatlng(e.latlng);
      });
    });
  });
});

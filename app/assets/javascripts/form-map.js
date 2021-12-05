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

    // Add search bar
    const SearchControl = window.GeoSearch.SearchControl;
    const OpenStreetMapProvider = window.GeoSearch.OpenStreetMapProvider;
    const provider = new OpenStreetMapProvider();

    const searchControl = new SearchControl({
      style: 'bar',
      provider: provider,
    });
    project_map.addControl(searchControl);

    var updateLatlng = latlng => {
      project_latitude.value = latlng.lat.toPrecision(8);
      project_longitude.value = latlng.lng.toPrecision(8);
    };

    var marker;

    var create_marker = latlng => {
      if(marker) leaflet_map.removeLayer(marker);

      marker = L.marker(latlng, {draggable:true}).addTo(leaflet_map);
      marker.on('drag', function(e) {
        updateLatlng(e.latlng);
      });
    };

    create_marker({lat: project_latitude.value, lng: project_longitude.value});

    var latlngTextListener = e => {
      var latlng = {
        lat: project_latitude.value,
        lng: project_longitude.value
      };

      create_marker(latlng);

      leaflet_map.panTo(latlng)
    };

    project_latitude.addEventListener('input', latlngTextListener);
    project_longitude.addEventListener('input', latlngTextListener);

    leaflet_map.on('click', function(e){
      updateLatlng(e.latlng);
      create_marker(e.latlng);
    });
  });
});

$(document).on('turbolinks:load', function() {
  $(".projects.edit").ready(function() {
    const map_id = 'form-map';
    const map_div = $(`#${map_id}`);
    if(map_div.length == 0) {
      return
    }
    
    const project_latitude = document.getElementById('project_latitude');
    const project_longitude = document.getElementById('project_longitude');

    const latitude = map_div.data('latitude');
    const longitude = map_div.data('longitude');
    const zoom = 10;
    const max_zoom = 16;
    const leaflet_map = L.map(map_id).setView([latitude, longitude], zoom);

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
      maxMarkers: 0,
      showMarker: false,
      autoClose: true,
      keepResult: true,
    });
    leaflet_map.addControl(searchControl);

    const updateLatlng = latlng => {
      project_latitude.value = latlng.lat.toPrecision(8);
      project_longitude.value = latlng.lng.toPrecision(8);
    };

    let marker;

    const create_marker = latlng => {
      if(marker) leaflet_map.removeLayer(marker);

      marker = L.marker(latlng, {draggable:true}).addTo(leaflet_map);
      // Update marker on drag
      marker.on('drag', function(e) {
        updateLatlng(e.latlng);
      });
    };

    create_marker({lat: project_latitude.value, lng: project_longitude.value});

    const latlngTextListener = e => {
      const latlng = {
        lat: project_latitude.value,
        lng: project_longitude.value
      };

      create_marker(latlng);

      leaflet_map.panTo(latlng)
    };

    // Update marker on searching for location in geosearch
    leaflet_map.on('geosearch/showlocation', (e) => {
      const latlng = {
        lat: e.location.y,
        lng: e.location.x,
      };
      updateLatlng(latlng);
      create_marker(latlng)
    });

    // Update marker on updated input in latitude/longitude text fields
    project_latitude.addEventListener('input', latlngTextListener);
    project_longitude.addEventListener('input', latlngTextListener);

    // Update marker on clicking on the form's map
    leaflet_map.on('click', function(e){
      updateLatlng(e.latlng);
      create_marker(e.latlng);
    });
  });
});

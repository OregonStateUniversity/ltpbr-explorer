$(document).on('turbolinks:load', function () {
  const addMap = function(projects, map_id) {
    if($(`#${map_id}`).length == 0) {
      return
    }

    // Inital map view options
    const zoom = 6;
    const map_center_lat = 44.5;
    const map_center_lon = -120.5;

    // Map tiles
    const Esri_NatGeoWorldMap = L.tileLayer(
      'https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}', {
        minZoom: 1,
        maxZoom: 16
      }
    );

    const Esri_WorldImagery = L.tileLayer(
      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}');

    // Create the map
    const project_map = L.map(map_id).setView([map_center_lat, map_center_lon], zoom);

    // Add imagery
    Esri_NatGeoWorldMap.addTo(project_map);

    // Layer control
    const baseLayers = {
      '<img class="leaflet-control-layers-img img-thumbnail" src="/map_layer_topography_example.png"><div class=leaflet-control-layers-text>Topography</div>': Esri_NatGeoWorldMap,
      '<img class="leaflet-control-layers-img img-thumbnail" src="/map_layer_imagery_example.png"><div class=leaflet-control-layers-text>Imagery</div>': Esri_WorldImagery
    };
    const layer_control_options = {
      // collapsed: false
    }
    const layer_control = L.control.layers(baseLayers, null, layer_control_options);
    layer_control.addTo(project_map);

    $('.leaflet-control-layers-selector:checked').parent().closest('label').addClass('leaflet-control-layers-selected');
    $('.leaflet-control-layers-selector:not(:checked)').parent().closest('label').addClass('leaflet-control-layers-unselected');
    $('.leaflet-control-layers-selector').change(
      function (){
        $('.leaflet-control-layers-selector').parent().closest('label').addClass('leaflet-control-layers-unselected');
        if ($(this).is(':checked')) {
          $(this).parent().closest('label')
            .removeClass('leaflet-control-layers-unselected')
            .addClass('leaflet-control-layers-selected');
        }
      }
    );

    // add scale bar
    L.control.scale().addTo(project_map);

    // project points now
    const project_markers = L.markerClusterGroup();

    projects.forEach(project => {
      const marker = L.marker([project.latitude, project.longitude]);
      const dateOptions = { 
        year: 'numeric', 
        month: 'short', 
        day: 'numeric' 
      };
      const updated_at = project.updated_at.replace(' UTC', '');
      const popup = L.popup({
        maxWidth: 600,
        minWidth: 400,
      }).setContent(
        `<div class='container'>
          <div class='row border-bottom mx-auto'>
            <span class='h2'>${project.name}</span>
          </div>
          <div class='row my-1 border-bottom marker-info'>
            <div class='col-md-8 my-2'>
              <img class='img-thumbnail shadow rounded' src='${project.cover_photo_url ? project.cover_photo_url : '/assets/missing_image_camera.png'}'>
            </div>
            <div class='col-md-4'>
              <div class='row my-1 border-bottom'>
                <label class='marker-info-text'>Stream:</label>
                <span class='marker-info-text font-weight-bold'>${project.stream_name}</span>
              </div>
              <div class='row my-1 border-bottom'>
                <label class='marker-info-text'>Watershed:</label>
                <span class='marker-info-text font-weight-bold'>${project.watershed}</span>
              </div>
              <div class='row my-1 border-bottom'>
                <label class='marker-info-text'>Length:</label><br>
                <span class='marker-info-text font-weight-bold'>${project.length} m</span>
              </div>
              <div class='row my-1'>
                <label class='marker-info-text'>Structures:</label><br><br><br>
                <span class='marker-info-text font-weight-bold'>${project.number_of_structures}</span>
              </div>
            </div>
          </div>
          <div class='row mx-auto my-1'>
            <label class='marker-info-text'>Implementation Date:</label>
            <span class='marker-info-text font-weight-bold'>${new Date(project.implementation_date).toLocaleString(undefined, dateOptions)}</span>
          </div>
          <div class='row mx-auto my-1'>
            <label class='marker-info-text'>Last Updated:</label>
            <span class='marker-info-text font-weight-bold'>${new Date(updated_at).toLocaleString(undefined, dateOptions)}</span>
          </div>
          <div class='row mx-auto btn-group'>
            <a class='btn btn-primary text-white' href='/projects/${project.id}'>View Project</a>
          </div>
        </div>`
      );
      
      marker.bindPopup(popup);
      project_markers.addLayer(marker);
    });
      
    // add all projects to map
    project_markers.addTo(project_map);

    // fit display to points on the map
    project_map.fitBounds(project_markers.getBounds());

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
    project_map.addControl(searchControl);
  }

  if(typeof(gon) === "undefined") {
    return
  }

  if(typeof(gon.state_name) === "undefined"){
    $(addMap(gon.projects, "master-map"));
  } else {
    let state_name = gon.state_name;
    $(addMap(gon.projects, "state-map"));
  }
});

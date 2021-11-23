$(document).on('turbolinks:load', function () {
  $(".static.projects_map").ready(function () {
    var projects = gon.projects.projects;
    var zoom = 6;
    var map_center_lat = 44.5;
    var map_center_lon = -120.5;

    var Esri_NatGeoWorldMap = L.tileLayer(
      'https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}', {
        minZoom: 1,
        maxZoom: 16
      }
    );

    var Esri_WorldImagery = L.tileLayer(
      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}');

    // Create the map
    var project_map = L.map("master-map").setView([map_center_lat, map_center_lon], zoom);

    // Add imagery
    Esri_NatGeoWorldMap.addTo(project_map);

    // Layer control
    var baseLayers = {
      '<img src=\'map_layer_topography_example.png\'>Topography': Esri_NatGeoWorldMap,
      '<img src=\'map_layer_imagery_example.png\'>Imagery': Esri_WorldImagery
    };

    var layer_control = L.control.layers(baseLayers);
    layer_control.addTo(project_map);

    //jQuery(function($){$('.leaflet-control-layers-toggle').append('test');});

    // add scale bar
    L.control.scale().addTo(project_map);

    // project points now
    var project_markers = L.featureGroup();

    projects.forEach(project => {
      var marker = L.marker([project.latitude, project.longitude]);
      var dateOptions = { 
        year: 'numeric', 
        month: 'short', 
        day: 'numeric' 
      };
      var updated_at = project.updated_at.replace(' UTC', '');
      var popup = L.popup({
        maxWidth: 600,
        minWidth: 400,
      }).setContent(
        `<div class='container'>
          <div class='row border-bottom mx-auto'>
            <span class='h2'>${project.name}</span>
          </div>
          <div class='row my-1 border-bottom marker-info'>
            <div class='col-md-8 my-2'>
              <img class='img-thumbnail shadow rounded' src='${project.photo}'>
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
  });
});
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

    var baseLayers = {
      'Topography': Esri_NatGeoWorldMap,
      'Imagery': Esri_WorldImagery
    };

    // Create the map
    var project_map = L.map("master-map").setView([map_center_lat, map_center_lon], zoom);

    // Add imagery
    Esri_NatGeoWorldMap.addTo(project_map);


    // layer control
    var layer_control = L.control.layers(baseLayers);
    layer_control.addTo(project_map);

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
      var popup = L.popup({
        maxWidth: 400,
        minWidth: 400,
      }).setContent(
        `<div class='container'>
          <div class='row border-bottom mx-auto'>
            <span class='h2'>${project.name}</span>
          </div>
          <div class='row my-2 border-bottom marker-info'>
            <div class='col-md-8 my-4'>
              <img class='img-thumbnail shadow rounded' src='${project.photo}'>
            </div>
            <div class='col-md-4'>
              <div class='row my-2 border-bottom'>
                <label class='h6'>Stream:</label>
                <span class='h6 font-weight-bold'>${project.stream_name}</span>
              </div>
              <div class='row my-2 border-bottom'>
                <label class='h6'>Watershed:</label>
                <span class='h6 font-weight-bold'>${project.watershed}</span>
              </div>
              <div class='row my-2 border-bottom'>
                <label class='h6'>Treatment Length (m):</label>
                <span class='h6 font-weight-bold'>${project.length}</span>
              </div>
              <div class='row my-2'>
                <label class='h6'>LT-PBR Structures:</label>
                <span class='h6 font-weight-bold'>${project.number_of_structures}</span>
              </div>
            </div>
          </div>
          <div class='row mx-auto my-2 marker-info'>
            <label class='h6 font-weight-bold'>Implementation Date:</label>
            <span class='h6'>${new Date(project.implementation_date).toLocaleString(undefined, dateOptions)}</span>
          </div>
          <div class='row mx-auto my-2 marker-info'>
            <label class='h6 font-weight-bold'>Last Updated:</label>
            <span class='h6'>${new Date(project.updated_at).toLocaleString(undefined, dateOptions)}</span>
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
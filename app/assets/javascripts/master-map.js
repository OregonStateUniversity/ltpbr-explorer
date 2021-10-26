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
    var Projects = L.featureGroup();

    for (var i = 0; i < projects.length; i++) {
      var marker = L.marker([projects[i].latitude, projects[i].longitude]);
      marker.bindPopup("<b>" +
        projects[i].name +
        "</b><br>Stream: " +
        projects[i].stream_name +
        "</b><br>Watershed: " +
        projects[i].watershed +
        "<br><a href='/projects/" +
        projects[i].id +
        "'>View Project</a>"
      );
      Projects.addLayer(marker);
    }

    // add all projects to map
    Projects.addTo(project_map);

    // fit display to points on the map
    project_map.fitBounds(Projects.getBounds());
  });
});
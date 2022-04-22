$(document).on('turbolinks:load', function() {
  const stats_id = 'project-stats';
  const stats_div = $(`#${stats_id}`);
  if(stats_div.length == 0) {
    return
  }
  
  const projects = gon.projects;
  const project_dates = projects.map(p => new Date(p.updated_at.replace(' UTC', '')))
  const project_lengths = projects.map(p => p.length)
  const project_structures = projects.map(p => p.number_of_structures)

});

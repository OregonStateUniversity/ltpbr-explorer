$(document).on('turbolinks:load', function() {
  const stats_id = 'project-stats';
  const stats_div = $(`#${stats_id}`);
  if(stats_div.length == 0) {
    return
  }
  
  // Assumes that projects are given in descending order of implementation
  const projects = gon.projects;
  // Reverse project order to have oldest first
  projects.reverse();
  // Load project data
  const project_dates = projects.map(p => new Date(p.implementation_date.replace(' UTC', '')));
  
  const cumulative_sum = arr => arr.map((e, i, arr) => i === 0 ? e : arr[i - 1] + e);
  const length_over_time = cumulative_sum(projects.map(p => p.length));
  const structures_over_time = cumulative_sum(projects.map(p => p.number_of_structures));

  // Create array of readable project dates
  const dateOptions = { 
    year: 'numeric', 
    month: 'short', 
    day: 'numeric' 
  };
  const labels = project_dates.map(d => d.toLocaleString(undefined, dateOptions));

  // Canvas for chart
  stats_div.append('<canvas id="project-stats-chart"></canvas>');
  const ctx = $(`#project-stats-chart`);

  const data = {
    labels: labels,
    datasets: [{
      label: 'Length Restored Over Time (mi)',
      backgroundColor: 'rgb(255, 99, 132)',
      borderColor: 'rgb(255, 99, 132)',
      data: length_over_time,
    }]
  };

  const config = {
    type: 'line',
    data: data,
    options: {}
  };
  
  var myChart = new Chart(ctx, config);

});

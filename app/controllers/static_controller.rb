class StaticController < ApplicationController
  def home
    @project_count = Project.project_count
    @structure_sum = Project.structure_sum
    @project_total_length_km = Project.project_total_length_km
  end

  def about; end

  def projects_map
    @disable_footer = false
    @projects = Project.all
    gon.rabl :template => 'app/views/shared/projects.rabl'
  end
end

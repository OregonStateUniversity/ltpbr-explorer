class StaticController < ApplicationController
  def home; end

  def about; end

  def projects_map
    @projects = Project.all
    gon.rabl 'app/views/static/home.rabl', as: 'projects'
  end
end

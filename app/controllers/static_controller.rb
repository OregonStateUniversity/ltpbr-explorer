class StaticController < ApplicationController
  def home
    @projects = Project.all
    gon.rabl 'app/views/static/home.rabl', as: 'projects'
  end

  def about; end

  def projects_map; end
end

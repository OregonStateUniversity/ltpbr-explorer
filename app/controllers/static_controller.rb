class StaticController < ApplicationController
  def home
    @projects = Project.all
    gon.rabl 'app/views/static/home.rabl', as: 'projects'
  end
end

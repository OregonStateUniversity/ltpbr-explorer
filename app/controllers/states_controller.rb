class StatesController < ApplicationController
  def index
    @states = State.select(*State.attribute_names.reject{ |attr| attr=='geom' }).order(:name)
  end

  def show
    @state = State.find(params[:id])
    @state_projects = @state.projects
    gon.rabl 'app/views/states/projects.rabl', as: 'projects'
  rescue ActiveRecord::RecordNotFound
    redirect_to states_path, warning: 'That state does not exist.'
  end

end

class StatesController < ApplicationController
  def index
    @states = State.select(*State.attribute_names.reject{ |attr| attr=='geom' }).order(:name)
  end

  def show
    @state = State.find(params[:id])
    @projects = @state.projects
    gon.state_name = @state.name
    gon.rabl :template => 'app/views/shared/projects.rabl'
  rescue ActiveRecord::RecordNotFound
    redirect_to states_path, warning: 'That state does not exist.'
  end

end
class StatesController < ApplicationController
  @states = State.select(*State.attribute_names.reject{ |attr| attr=='geom' })
  def index
    @states = State.select(*State.attribute_names.reject{ |attr| attr=='geom' }).order(:name)
  end

  def show
    @state = State.find(params[:id])
    @state_projects = @state.projects
  rescue ActiveRecord::RecordNotFound
    redirect_to states_path, warning: 'That state does not exist.'
  end

end

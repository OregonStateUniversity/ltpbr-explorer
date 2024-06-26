require 'hash'

class StatesController < ApplicationController
  include Pagy::Backend

  def index
    @states = State.with_projects.without_geom.order('projects_count DESC, name')
  end

  def show
    ActiveStorage::Current.url_options = {host: request.host, port: request.port } if Rails.env.development?
    @state = State.find(params[:id])
    respond_to do |format|
      format.json
      format.html do
        @projects = @state.projects
        gon.state_name = @state.name
        gon.rabl :template => 'app/views/shared/projects.rabl'
        @chart_project_count = @projects.group_by_day(:implementation_date, format: "%d %b %Y").count.accumulate!
        @chart_structure_count = @projects.group_by_day(:implementation_date).sum(:number_of_structures).accumulate!
        @chart_total_length = @projects.group_by_day(:implementation_date).sum(:length).accumulate!.transform_values! { |v| v / 1000.0 }
        @pagy, @projects = pagy(@projects)
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to states_path, alert: 'That state does not exist.'
  end

end

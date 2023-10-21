class StatesController < ApplicationController

  def index
    @states = State.with_projects.without_geom.order(:name)
  end

  def show
    @state = State.find(params[:id])
    @projects = @state.projects
    gon.state_name = @state.name
    gon.rabl :template => 'app/views/shared/projects.rabl'

    #Group up project entries by month through implementation date, and run the accumulation function to create a cumulative graph instead 
    #of line graph. Then, reject all dates if their timestamp is greater than the currently set timestamp
    @chart_project_count = accumulate_data(@projects.group_by_day(:implementation_date, format: "%d %b %Y").count)
    @chart_structure_count = accumulate_data(@projects.group_by_day(:implementation_date).sum(:number_of_structures))
    #Convert from m to km at the end
    @chart_total_length = accumulate_data(@projects.group_by_day(:implementation_date).sum(:length)).transform_values! { |v| v / 1000.0}


  rescue ActiveRecord::RecordNotFound
    redirect_to states_path, warning: 'That state does not exist.'
  end

  def accumulate_data(data)
    accumulator = 0
    data.transform_values! do |val|
      val += accumulator
      accumulator = val
    end
  end

end

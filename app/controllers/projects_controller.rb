class ProjectsController < ApplicationController

  def index
  end

  def show; end

  def new
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path
      flash[:success] = 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project
      flash[:success] = 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
    flash[:success] = 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:affiliation, :stream_name, :implementation_date,
      :narrative, :area, :maintenance, :primary_contact)
  end
end

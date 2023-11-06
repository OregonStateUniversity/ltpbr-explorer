class ProjectCoverPhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :require_author_or_admin

  def edit
  end

  def update
    if params.has_key?('project') && @project.update(project_params)
      redirect_to @project
      flash[:success] = 'Project cover photo has been updated.'
    else
      flash[:warning] = "Please select a new cover photo to upload."
      render :edit
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
    @project.longitude = @project.lonlat.x
    @project.latitude = @project.lonlat.y
  end

  def project_params
    params.require(:project).permit(:cover_photo)
  end

end

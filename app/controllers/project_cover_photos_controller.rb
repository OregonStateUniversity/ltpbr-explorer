class ProjectCoverPhotosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :map, :show]
  before_action :set_project, only: [:edit, :update]
  before_action :require_author_or_admin, only: [:edit, :update, :destroy]

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

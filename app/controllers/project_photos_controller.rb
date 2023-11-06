class ProjectPhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :require_author_or_admin

  def index
    @photos = @project&.photos || []
  end

  def create
    if !params.has_key?('project')
      flash[:warning] = "Please select photos to upload."
      render :index
      return
    end
    if @project.update(project_params)
      redirect_to @project
      flash[:success] = 'Photo has been added.'
    else
      flash[:warning] = 'Could not add the photo.'
      render :index
    end
  end

  def destroy
    # TODO
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
    @project.longitude = @project.lonlat.x
    @project.latitude = @project.lonlat.y
  end

  def project_params
    params.require(:project).permit(photos: [])
  end

end

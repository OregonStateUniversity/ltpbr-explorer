class ProjectPhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :require_author_or_admin

  def create
    @project_photo = ProjectPhoto.new(project_photo_params.merge(project: @project))
    if @project_photo.save
      redirect_to project_url(@project)
      flash[:success] = 'Photo has been added.'
    else
      flash[:warning] = 'Could not add the photo. Be sure to select an image file smaller than 50MB.'
      redirect_to project_url(@project)
    end
  end

  def edit
    @project_photo = ProjectPhoto.find(params[:id])
  end

  def update
    @project_photo = ProjectPhoto.find(params[:id])
    if @project_photo.update(project_photo_params)
      redirect_to project_url(@project), notice: 'Photo was successfully updated.'
    else
      render :edit, status: :unprocessable_entity, warning: 'Could not update the photo.'
    end
  end

  def destroy
    @project_photo = ProjectPhoto.find(params[:id])
    @project_photo.destroy
    redirect_to project_url(@project), notice: 'Photo was successfully removed.'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def project_photo_params
    params.require(:project_photo).permit(:description, :date, :image)
  end

end

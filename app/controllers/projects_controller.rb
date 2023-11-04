class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :map, :show]
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :require_author_or_admin, only: [:edit, :update, :destroy]

  def index
    @projects = Project.search(params[:query], params[:organization_id]).distinct.order(:name)
    @organizations = Organization.all.order(:name)
  end

  def map
    @projects = Project.all
    gon.rabl(template: 'app/views/shared/projects.rabl')
  end

  def show
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, warning: 'That project does not exist.'
  end

  def new
    @project = Project.new
    @organizations = Organization.all.order(:name)
  end

  def edit
    @project.longitude = @project.lonlat.x
    @project.latitude = @project.lonlat.y
    @organizations = Organization.all.order(:name)
    gon.cover_photo_id = @project.cover_photo_id
  end

  def create
    @project = Project.new(project_params.merge(author: current_user))
    if @project.save
      redirect_to @project
      flash[:success] = 'Project was successfully created. Add Organization roles or other affiliated Organizations with \'Manange Affiliations\''
    else
      @organizations = Organization.all.order(:name)
      render :new
    end
  end

  def update
    @organizations = Organization.all.order(:name)
    #update affiliation params before the rest of the params, otherwise it tries to update
    #non-existent affiliations if organizations are removed with out of order params
    @project.update(project_affiliation_params)

    if @project.update(project_params)
      # Set cover photo
      @project.update(cover_photo_id: params[:cover_photo_id])

      # Delete selected photos
      # Assumes selected photo is not the cover; assumption should hold with the javascript used in form
      # Must be done after setting cover photo to prevent violating foreign key constraint
      photos_selected_for_deletion = ActiveStorage::Attachment.where(id: params[:delete_photo_ids])
      photos_selected_for_deletion.map(&:purge)

      redirect_to @project
      flash[:success] = 'Project was successfully updated. Add roles to any newly affiliated Organizations with \'Manange Affiliations\''
    else
      # Delete uploaded photos if update failed - Rails 5.2 bug
      # @project.photos.purge
      # params[:photos].purge
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to current_user
    flash[:success] = 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
    @project.longitude = @project.lonlat&.x
    @project.latitude = @project.lonlat&.y
  end

  def project_affiliation_params
    params.require(:project).permit(:id, {affiliations_attributes: [:id, :role]})
  end

  def project_params
    params.require(:project).permit({organization_ids: []}, :stream_name, :implementation_date,
      :narrative, :length, :primary_contact, :longitude, :latitude, :number_of_structures,
      :structure_description, :name, :watershed, :url, :cover_photo, photos: [])
  end

end

class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_owner, only: [:edit, :update, :destroy]
  
  def index;
    @projects = Project.distinct.page(params[:page]).search(params[:search], params[:search_organization])
    @filtered_count = @projects.count
    @result_plurality = @projects.count == 1 ? 'result' : 'results'
    @proj_plurality = @projects.count == 1 ? 'project' : 'projects'
  end

  def show
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, warning: 'That project does not exist.'

  end

  def new
    @project = Project.new
    @project_organizations = @project.organizations
    @organizations = Organization.all
  end

  def edit
    @project.longitude = @project.lonlat.x
    @project.latitude = @project.lonlat.y
    @project_organizations = @project.organizations
    @organizations = Organization.all
  end

  def create
    @project = Project.new(project_params)
    @project.author = current_user
    @project_organizations = @project.organizations
    @organizations = Organization.all

    if @project.save
      redirect_to @project
      flash[:success] = 'Project was successfully created. Add Organization roles or other affiliated Organizations with \'Manange Organizations and Roles\''
    else
      # Delete uploaded photos if creation failed - Rails 5.2 bug
      # @project.photos.purge
      render :new
    end
  end

  def update
    # Delete selected photos
    photos_selected_for_deletion = ActiveStorage::Attachment.where(id: params[:select_delete_photo_ids])
    photos_selected_for_deletion.map(&:purge)

    @organizations = Organization.all
    @project = Project.find(params[:id])
    #update affiliation params before the rest of the params, otherwise it tries to update
    #non-existent affiliations if organizations are removed with out of order params
    @project.update(project_affiliation_params)

    if @project.update(project_params)
      redirect_to @project
      flash[:success] = 'Project was successfully updated. Add roles to any newly affiliated Organizations with \'Manange Organizations and Roles\''
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
  end

  def project_affiliation_params
    params.require(:project).permit(:id, {affiliations_attributes: [:id, :role]})
  end

  def project_params
    params.require(:project).permit(:id, :organization, {organization_ids: []}, :stream_name, :implementation_date,
      :narrative, :length, :primary_contact, :longitude, :latitude, :number_of_structures,
      :structure_description, :name, :watershed, :url, photos: [])
  end

  def require_owner
    unless (@project.author_id == current_user.id) | (current_user.admin_role?)
      redirect_to root_path
      flash[:alert] = 'Restricted action, must own project.'
    end
  end
end

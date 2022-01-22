class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_owner, only: [:edit, :update, :destroy]

  $displaylimit = 15

  def index;
    @projects = Project.page(params[:page]).per($displaylimit)

    if params[:order] == 'name'
        @projects = Project.page(params[:page]).per($displaylimit).order('name')
    elsif params[:order] == 'watershed'
        @projects = Project.page(params[:page]).per($displaylimit).order('watershed')
    elsif params[:order] == 'stream_name'
        @projects = Project.page(params[:page]).per($displaylimit).order('stream_name')
    elsif params[:order] == 'watershed'
        @projects = Project.page(params[:page]).per($displaylimit).order('affiliation')
    elsif params[:order] == 'normal'
        @projects = Project.page(params[:page]).per($displaylimit)
    end
  end

  def show
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, warning: 'That project does not exist.'
  end

  def new
    @project = Project.new
  end

  def edit
    @project.longitude = @project.lonlat.x
    @project.latitude = @project.lonlat.y
  end

  def create
    @project = Project.new(project_params)
    @project.author = current_user
    if @project.save
      redirect_to @project
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
    redirect_to current_user
    flash[:success] = 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:affiliation, :stream_name, :implementation_date,
      :narrative, :length, :primary_contact, :longitude, :latitude, :number_of_structures, :photo,
      :structure_description, :name, :watershed, :url)
  end

  def require_owner
    unless (@project.author_id == current_user.id) | (current_user.admin_role?)
      redirect_to root_path
      flash[:alert] = 'Restricted action, must own project.'
    end
  end
end

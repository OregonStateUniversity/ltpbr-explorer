class OrganizationsController < ApplicationController
  require 'date'
  before_action :set_organization, only: %w[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_admin, only: [:edit, :new, :create, :update, :destroy], except: [:show, :index]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    #Time window up to today to show projects on graph
    @timestamp = 3.year.ago
    #Gather all Projects associated with this organization
    @organization_projects = @organization.projects

    #Group up project entries by month through implementation date, and run the accumulation function to create a cumulative graph instead 
    #of line graph. Then, reject all dates if their timestamp is greater than the currently set timestamp
    @chart_project_count = accumulate_data(@organization_projects.group_by_month(:implementation_date, format: "%b %Y").count).keep_if { |i, _| i > @timestamp }
    @chart_structure_count = accumulate_data(@organization_projects.group_by_month(:implementation_date).sum(:number_of_structures)).keep_if { |i, _| i > @timestamp }
    #Convert from m to km at the end
    @chart_total_length = accumulate_data(@organization_projects.group_by_month(:implementation_date).sum(:length)).keep_if { |i, _| i > @timestamp }.transform_values { |v| v / 1000}

    @project_count = @organization_projects.count
    @structure_sum = @organization_projects.structure_sum
    @project_total_length_km = @organization_projects.project_total_length_km
    @project_total_length_mi = (@project_total_length_km* 0.6214).floor(1)
  end

  def accumulate_data(data)
    accumulator = 0
    data.transform_values! do |val|
      val += accumulator
      accumulator = val
    end
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: "Organization was successfully created." }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: "Organization was successfully updated." }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: "Organization was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organization_params
        params.require(:organization).permit(:name, :description, :contact, :website, :icon)
    end

    def require_admin
        unless current_user.admin_role?
          redirect_to root_path
          flash[:alert] = 'Restricted action, must be an Admin'
        end
    end
end

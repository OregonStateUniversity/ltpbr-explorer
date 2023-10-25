require 'hash'

class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_admin, except: [:show, :index]
  before_action :set_organization, only: %w[ show edit update destroy ]

  def index
    @organizations = Organization.order('affiliations_count DESC, name')
  end

  def show
    @organization_projects = @organization.projects
    @chart_project_count = @organization_projects.group_by_day(:implementation_date, format: "%d %b %Y").count.accumulate!
    @chart_structure_count = @organization_projects.group_by_day(:implementation_date).sum(:number_of_structures).accumulate!
    @chart_total_length = @organization_projects.group_by_day(:implementation_date).sum(:length).accumulate!.transform_values { |v| v / 1000.0}
    @project_count = @organization_projects.count
    @structure_sum = @organization_projects.structure_sum
    @project_total_length_km = @organization_projects.project_total_length_km
    @project_total_length_mi = (@project_total_length_km* 0.6214).floor(1)
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

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

  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: "Organization was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:name, :description, :contact, :website, :logo)
    end

end

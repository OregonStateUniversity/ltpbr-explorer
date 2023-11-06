class AffiliationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :require_author_or_admin
  before_action :set_affiliation, only: %w[ edit update destroy ]

  def index
    @affiliations = @project.affiliations
    @affiliation = Affiliation.new
    @organizations = Organization.all.order(:name)
  end

  def edit
    @organizations = Organization.all.order(:name)
  end

  def create
    @affiliation = @project.affiliations.build(affiliation_params)
    respond_to do |format|
      if !@affiliation.valid?
        format.html { redirect_to request.referer, alert: 'Error: Duplicate or Invalid Organization' }
      end
      if @affiliation.save
        format.html { redirect_to project_affiliations_path(@project), notice: "Affiliation was successfully created." }
        format.json { render :show, status: :created, location: @affiliation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @affiliation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if !@affiliation.valid?
        format.html { redirect_to request.referer, alert: 'Error: Duplicate or Invalid Organization' }
      end
      if @affiliation.update(affiliation_params)
        format.html { redirect_to project_affiliations_path(@project), notice: "Affiliation was successfully updated." }
        format.json { render :show, status: :ok, location: @affiliation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @affiliation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @affiliation.destroy
    respond_to do |format|
      format.html { redirect_to project_affiliations_path(@project), notice: "Affiliation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def affiliation_params
      params.require(:affiliation).permit(:role, :organization_id, :project_id)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_affiliation
      @affiliation = @project.affiliations.find(params[:id])
    end

end

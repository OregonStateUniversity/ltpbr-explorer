class AffiliationsController < ApplicationController
  before_action :get_project
  before_action :set_affiliation
  before_action :set_affiliation, only: %w[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :require_owner

  # GET /affiliations
  # GET /affiliations.json
  def index
    @affiliations = @project.affiliations
    @affiliation = Affiliation.new
  end

  # GET /affiliations/1
  # GET /affiliations/1.json
  def show
  end

  # GET /affiliations/new
  def new
    @affiliation = @project.affiliations.build
  end

  # GET /affiliations/1/edit
  def edit
  end

  # POST /affiliations
  # POST /affiliations.json
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

  # PATCH/PUT /affiliations/1
  # PATCH/PUT /affiliations/1.json
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

  # DELETE /affiliations/1
  # DELETE /affiliations/1.json
  def destroy
    @affiliation.destroy
    respond_to do |format|
      format.html { redirect_to project_affiliations_path(@project), notice: "Affiliation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def get_project
      @project = Project.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_affiliation
      @affiliation = @project.affiliations.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def affiliation_params
        params.require(:affiliation).permit(:role, :organization_id, :project_id,)
    end

    def require_owner
      unless (@project.author_id == current_user.id) | (current_user.admin_role?)
        redirect_to root_path
        flash[:alert] = 'Restricted action, must own project.'
      end
    end
end

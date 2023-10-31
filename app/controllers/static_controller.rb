class StaticController < ApplicationController
  def home
    @project_count = Project.count
    @structure_sum = Project.sum(:number_of_structures)
    @project_total_length_km = Project.project_total_length_km
    @project_total_length_mi = (Project.project_total_length_km * 0.6214).floor(1)
    @organization_sum = Organization.count
    @unique_state_count = Project.distinct.count('state_id')
  end

  def about; end

end

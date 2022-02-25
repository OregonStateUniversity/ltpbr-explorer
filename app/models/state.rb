class State < ApplicationRecord
  belongs_to :country

  def country_name
    Country.find(self.country_id).name
  end

  def projects
    Project.where(state_id: self.id)
  end

  def project_count
    projects.count
  end

  def structure_sum
    projects.sum(:number_of_structures)
  end

  def project_total_length_km
    total_km = projects.sum(:length)/1000.to_f
    total_km.round(1)
  end

end

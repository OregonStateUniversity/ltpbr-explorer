class State < ApplicationRecord

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

  def project_total_length_mi
    (project_total_length_km() * 0.6214).floor(1)
  end

end

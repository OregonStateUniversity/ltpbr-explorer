class State < ApplicationRecord

  has_many :projects, dependent: :restrict_with_error

  validates :name, presence: true
  validates :iso_code, presence: true
  validates :geom, presence: true

  scope :with_projects, -> { where('projects_count > 0') }
  scope :without_geom, -> { select(State.attribute_names - ['geom']) }

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

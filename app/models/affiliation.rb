class Affiliation < ApplicationRecord

  belongs_to :organization, counter_cache: true
  belongs_to :project, counter_cache: true

  validates :organization_id, uniqueness: { scope: :project_id }

end

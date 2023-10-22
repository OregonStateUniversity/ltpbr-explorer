class Affiliation < ApplicationRecord

  belongs_to :organization
  belongs_to :project

  validates :organization_id, uniqueness: { scope: :project_id }

end

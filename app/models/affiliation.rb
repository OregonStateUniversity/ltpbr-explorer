class Affiliation < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :organization
  validates_uniqueness_of :organization_id, :scope => [:project_id]
end

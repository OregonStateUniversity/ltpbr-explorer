class Affiliation < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :organization
end

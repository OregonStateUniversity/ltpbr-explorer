class Affiliation < ApplicationRecord
  belongs_to :project
  belongs_to :organization
end

class Affiliation < ApplicationRecord
    belongs_to :projects
    belongs_to :organizations

end

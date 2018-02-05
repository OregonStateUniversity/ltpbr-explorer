class Project < ApplicationRecord
  validates :affiliation, :stream_name, :implementation_date, :primary_contact, presence: true
  validates_numericality_of :area, only_integer: true, greater_than: 0
end

class Project < ApplicationRecord
  attr_accessor :longitude, :latitude
  validates :affiliation, :stream_name, :implementation_date, :primary_contact, presence: true
  validates_numericality_of :area, only_integer: true, greater_than: 0

  def assign_lonlat(longitude, latitude)
    update_attribute(:lonlat, "POINT(#{longitude}, #{latitude})")
  end
end

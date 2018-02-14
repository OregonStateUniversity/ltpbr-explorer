class Project < ApplicationRecord
  attr_accessor :longitude, :latitude

  belongs_to :author, class_name: 'User'

  before_save :assign_lonlat, on: :create

  validates :affiliation, :stream_name, :implementation_date, :primary_contact,
            :longitude, :latitude, presence: true

  validates_numericality_of :area, only_integer: true, greater_than: 0

  has_attached_file :photo, styles: { default: '400x400#' }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  private

  def assign_lonlat
    if @longitude.present? && @latitude.present?
      mfactory = RGeo::ActiveRecord::SpatialFactoryStore.instance.factory(:geo_type => 'point')
      self.lonlat = mfactory.point(longitude, latitude)
    else
      throw(:abort)
    end
  end

end

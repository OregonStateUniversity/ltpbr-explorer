class Project < ApplicationRecord
  attr_accessor :longitude, :latitude

  belongs_to :author, class_name: 'User'

  before_save :assign_lonlat, on: :create

  validates :affiliation, :stream_name, :implementation_date, :primary_contact,
            :longitude, :latitude, presence: true

  validates_numericality_of :area, only_integer: true, greater_than: 0
  validates_numericality_of :latitude, greater_than: -90, less_than: 90
  validates_numericality_of :longitude, greater_than: -180, less_than: 180

  has_attached_file :photo, styles: { default: '700x400>', convert_options: { default: '-quality 75 -strip'} }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  def title
    "Project on #{stream_name}"
  end

  def byline
    if affiliation.present?
      "Implemented on #{implementation_date.to_formatted_s(:long)} in affiliation with #{affiliation}"
    else
      "Implemented on #{implementation_date.to_formatted_s(:long)}"
    end
  end

  private

  def round_string(str, precision)
    return str.to_f.round(precision).to_s
  end

  def assign_lonlat
    if @longitude.present? && @latitude.present?
      mfactory = RGeo::ActiveRecord::SpatialFactoryStore.instance.factory(:geo_type => 'point')
      self.lonlat = mfactory.point(round_string(longitude,6), round_string(latitude,6))
    else
      throw(:abort)
    end
  end

end

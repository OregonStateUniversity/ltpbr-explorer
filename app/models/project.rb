class Project < ApplicationRecord

  attr_accessor :longitude, :latitude

  belongs_to :author, class_name: 'User'

  before_save :assign_lonlat

  validates :name, :affiliation, :stream_name, :implementation_date, :primary_contact,
            :longitude, :latitude, :narrative, :structure_description, :watershed,
            :url, presence: true

  validates_numericality_of :length, only_integer: true, greater_than: 0
  validates_numericality_of :latitude, greater_than: -90, less_than: 90, message: 'must be in decimal notation'
  validates_numericality_of :longitude, greater_than: -180, less_than: 180, message: 'must be in decimal notation'
  validates_numericality_of :number_of_structures, only_integer: true, greater_than: 0

  validates_format_of :implementation_date, :with => /\d{4}\-\d{2}\-\d{2}/, :message => 'must be in the following format: yyyy-mm-dd'

  has_attached_file :photo,
    styles: { default: '700x400>',
    convert_options: { default: '-quality 75 -strip'}},
    default_url: 'missing_image.jpg'

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

  def self.project_count
    all.count
  end

  def self.structure_sum
    sum(:number_of_structures)
  end

  def self.project_total_length_km
    total_km = sum(:length)/1000.to_f
    return total_km.round(1)
  end

  private

  def round_string(str, precision)
    return str.to_f.round(precision).to_s
  end

  def assign_lonlat
    if @longitude.present? && @latitude.present?
      mfactory = RGeo::ActiveRecord::SpatialFactoryStore.instance.factory(:geo_type => 'point')
      self.lonlat = mfactory.point(round_string(longitude, 6), round_string(latitude, 6))
    else
      throw(:abort)
    end
  end

end

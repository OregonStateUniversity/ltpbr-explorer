class Project < ApplicationRecord

  attr_accessor :longitude, :latitude

  belongs_to :author, class_name: 'User'
  belongs_to :state, optional: true, counter_cache: true
  has_many :affiliations, dependent: :delete_all
  has_many :organizations, through: :affiliations

  has_many_attached :photos

  accepts_nested_attributes_for :affiliations

  validates :name, :stream_name, :implementation_date, :primary_contact,
            :longitude, :latitude, :narrative, :structure_description, :watershed,
            presence: true
  validates_numericality_of :length, only_integer: true, greater_than: 0
  validates_numericality_of :latitude, greater_than: -90, less_than: 90, message: 'must be in decimal notation'
  validates_numericality_of :longitude, greater_than: -180, less_than: 180, message: 'must be in decimal notation'
  validates_numericality_of :number_of_structures, only_integer: true, greater_than: 0
  validates :photos, 
    content_type: [:png, :jpg, :jpeg, :gif, :bmp, :avif, :webp], 
    size: { less_than: 50.megabytes , message: 'must be below 50 MB in size each' }, 
    limit: { min: 0, max: 20, message: 'must have fewer than 20 photos'}

  before_save :assign_lonlat, :assign_state

  def authored_by?(user)
    author == user
  end

  def editable_by?(user)
    user&.admin_role? || authored_by?(user)
  end

  def calculate_state
    return nil if lonlat.nil?
    State.where(
      State.arel_table[:geom].st_contains(
        Arel.spatial("SRID=4326;#{self.lonlat}")
      )
    ).first
  end

  def cover_photo
    @cover_photo = "/missing_image_camera.png"

    if !self.cover_photo_id.nil? && self.photos.where(id: self.cover_photo_id).presence
      @cover_photo = Rails.application.routes.url_helpers.rails_blob_url(
        self.photos.where(id: self.cover_photo_id)[0],
        Rails.application.config.action_mailer.default_url_options
      )
    elsif self.photos[0].presence
      @cover_photo = Rails.application.routes.url_helpers.rails_blob_url(
        self.photos[0],
        Rails.application.config.action_mailer.default_url_options
      )
    end

    @cover_photo
  end

  def self.project_total_length_km
    total_km = sum(:length)/1000.to_f
    return total_km.round(1)
  end

  def self.project_total_length_mi
    (self.project_total_length_km * 0.6214).floor(1)
  end

  def self.search(query, organization_id)
    projects = Project.all
    if query && organization_id
      projects = projects.where(["projects.name ILIKE :query", query: "%#{query}%"]).or(
      projects = projects.where(["projects.watershed ILIKE :query", query: "%#{query}%"])).or(
      projects = projects.where(["stream_name ILIKE :query", query: "%#{query}%"]))
      if organization_id.length > 0
        projects = projects.joins(:organizations).where(organizations: {id: organization_id})
      end
      return projects
    else
      all
    end
  end

  def to_s
    name
  end

  private

  def round_string(str, precision)
    return str.to_f.round(precision).to_s
  end

  def assign_lonlat
    if @longitude.present? && @latitude.present?
      self.lonlat = RGeo::ActiveRecord::SpatialFactoryStore.instance
        .factory(:geo_type => 'point')
        .point(round_string(longitude, 6), round_string(latitude, 6))
    else
      throw(:abort)
    end
  end

  def assign_state
    self.state = calculate_state
  end

end

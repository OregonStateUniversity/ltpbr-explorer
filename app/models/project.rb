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

  def title
    "Project on #{stream_name}"
  end

  def authored_by?(user)
    author == user
  end

  def calculate_state
    point = "SRID=4326;#{self.lonlat}"
    states = State.arel_table
    containing_state = State.where(states[:geom].st_contains(Arel.spatial(point)))
    return containing_state.present? ? containing_state.first.id : nil
  end

  def project_organizations
    organizations
  end

  def organization_count
    organizations.length
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

  def photo_presence
    self.photos[0].present?
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

  def self.search(search, search_organization)
    projects = Project.all
    
    if search && search_organization
        projects = projects.where(["projects.name ILIKE :search", search: "%#{search}%"]).or(
        projects = projects.where(["projects.watershed ILIKE :search", search: "%#{search}%"])).or(
        projects = projects.where(["stream_name ILIKE :search", search: "%#{search}%"]))

        if search_organization.length > 0
            projects = projects.joins(:organizations).where(organizations: {id: search_organization})
        end
        return projects
    else
        all
    end
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

  def assign_state
    self.state_id = calculate_state
  end

end

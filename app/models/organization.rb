class Organization < ApplicationRecord

  has_many :affiliations, dependent: :delete_all
  has_many :projects, through: :affiliations

  has_one_attached :logo

  validates :name, presence: true
  validates :website, format: URI.regexp, allow_blank: true
  validates :logo,
    content_type: [:png, :jpg, :jpeg, :gif, :bmp, :avif, :webp],
    size: { less_than: 50.megabytes , message: 'must be below 50 MB in size' }

  def self.organization_count
    all.count
  end

  def organization_contact_info
    contact
  end

  def url?(string)
    uri = URI.parse(string)
    throw "MailToError" if uri.scheme == 'mailto'
    throw "TelError" if uri.scheme == 'tel'
    !uri.host.nil?
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  rescue => e
    !(e.to_s.include?("TelError") || e.to_s.include?("MailToError"))
  end

end

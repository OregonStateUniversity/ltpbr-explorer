class Organization < ApplicationRecord

  has_many :affiliations, dependent: :delete_all
  has_many :projects, through: :affiliations

  has_one_attached :logo

  validates :name, presence: true
  validates :website, format: URI.regexp, allow_blank: true
  validates :logo,
    content_type: [:png, :jpg, :jpeg, :gif, :bmp, :avif, :webp],
    size: { less_than: 50.megabytes , message: 'must be below 50 MB in size' }

end

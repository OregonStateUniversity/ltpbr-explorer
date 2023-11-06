class ProjectPhoto < ApplicationRecord
  belongs_to :project

  has_one_attached :image
  validates :image,
    content_type: [:png, :jpg, :jpeg, :gif, :bmp, :avif, :webp],
    size: { less_than: 50.megabytes , message: 'must be below 50 MB in size' }

end

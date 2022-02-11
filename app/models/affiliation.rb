class Affiliation < ApplicationRecord
    has_and_belongs_to_many :projects

    has_one_attached :icon

    validates :icon, 
    content_type: [:png, :jpg, :jpeg, :gif, :bmp, :avif, :webp], 
    size: { less_than: 50.megabytes , message: 'must be below 50 MB in size each' }, 
    limit: { min: 0, max: 20, message: 'must have fewer than 20 photos'}

    def small_icon
        return self.icon.variant(resize: '300x300')
    end
end

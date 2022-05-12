class Organization < ApplicationRecord

    has_many :affiliations, dependent: :delete_all
    has_many :projects, through: :affiliations

    has_one_attached :icon

    validates :icon, 
    content_type: [:png, :jpg, :jpeg, :gif, :bmp, :avif, :webp], 
    size: { less_than: 50.megabytes , message: 'must be below 50 MB in size each' }, 
    limit: { min: 0, max: 20, message: 'must have fewer than 20 photos'}

    def small_icon
        return self.icon.variant(resize: '300x300')
    end

    def self.organization_count
        all.count
    end

    def organization_contact_info
        contact
        url?(contact)
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

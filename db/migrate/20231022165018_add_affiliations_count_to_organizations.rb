class AddAffiliationsCountToOrganizations < ActiveRecord::Migration[7.1]

  class Affiliation < ApplicationRecord
    belongs_to :organization, counter_cache: true
    belongs_to :project, counter_cache: true
  end
  class Organization < ApplicationRecord
    has_many :affiliations, dependent: :delete_all
  end

  def up
    add_column :organizations, :affiliations_count, :integer, default: 0, null: false
    Organization.find_each do |organization|
      Organization.reset_counters(organization.id, :affiliations)
    end
  end

  def down
    remove_column :organizations, :affiliations_count
  end

end

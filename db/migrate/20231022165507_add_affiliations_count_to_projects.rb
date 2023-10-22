class AddAffiliationsCountToProjects < ActiveRecord::Migration[7.1]
  class Affiliation < ApplicationRecord
    belongs_to :organization, counter_cache: true
    belongs_to :project, counter_cache: true
  end
  class Project < ApplicationRecord
    has_many :affiliations, dependent: :delete_all
  end

  def up
    add_column :projects, :affiliations_count, :integer, default: 0, null: false
    Project.find_each do |project|
      Project.reset_counters(project.id, :affiliations)
    end
  end

  def down
    remove_column :projects, :affiliations_count
  end
end

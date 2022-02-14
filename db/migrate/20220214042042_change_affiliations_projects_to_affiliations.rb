class ChangeAffiliationsProjectsToAffiliations < ActiveRecord::Migration[5.2]
  def change
    rename_table :affiliations_projects, :affiliations
  end
end

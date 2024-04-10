class RemoveAffiliationLegacyFromProjects < ActiveRecord::Migration[7.1]
  def change
    remove_column :projects, :affiliation_legacy, :string
  end
end

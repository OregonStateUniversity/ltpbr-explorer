class AddAffiliationOrganizationProjectIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :affiliations, [:project_id, :organization_id], unique: true
  end
end

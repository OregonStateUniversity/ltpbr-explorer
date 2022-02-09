class FixProjectAffiliationColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :affiliation, :affiliation_legacy
  end
end

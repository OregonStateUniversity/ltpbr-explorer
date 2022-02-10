class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :affiliations, :name, :affiliation_name
  end
end

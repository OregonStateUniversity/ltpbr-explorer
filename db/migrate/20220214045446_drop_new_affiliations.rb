class DropNewAffiliations < ActiveRecord::Migration[5.2]
  def up
    drop_table :affiliations
  end
        
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end


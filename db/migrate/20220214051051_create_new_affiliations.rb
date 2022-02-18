class CreateNewAffiliations < ActiveRecord::Migration[5.2]
  def change
    create_table :affiliations do |t|
      t.references :project, foreign_key: true, null: false
      t.references :organization, foreign_key: true, null: false
      t.string :role

      t.timestamps
    end
  end
end

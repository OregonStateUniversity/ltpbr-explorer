class CreateAffiliations < ActiveRecord::Migration[5.2]
  def change
    create_table :affiliations do |t|
      t.string :name
      t.text :description
      t.string :contact
      t.string :website

      t.timestamps
    end
  end
end

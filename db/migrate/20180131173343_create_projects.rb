class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :affiliation
      t.string :stream_name
      t.string :implementation_date
      t.text :narrative
      t.integer :area
      t.boolean :maintenance
      t.string :primary_contact

      t.timestamps
    end
  end
end

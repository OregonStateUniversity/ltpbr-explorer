class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.references :country, foreign_key: true
      t.string :name
      t.string :hasc_code
      t.string :type
      t.multi_polygon :geom
      t.integer :total_length
      t.integer :total_number_of_structures

      t.timestamps
    end

    add_index :states, :geom, using: :gist
  end
end

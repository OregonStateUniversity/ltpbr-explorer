class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :name
      t.string :iso_code
      t.string :state_type
      t.multi_polygon :geom

      t.timestamps
    end

    add_index :states, :geom, using: :gist
  end
end

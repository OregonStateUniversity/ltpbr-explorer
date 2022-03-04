class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :iso_code
      t.multi_polygon :geom, :srid => 4326

      t.timestamps
    end

    add_index :countries, :name,      unique:   true
    add_index :countries, :iso_code,  unique:   true
    add_index :countries, :geom,      using: :gist
  end
end

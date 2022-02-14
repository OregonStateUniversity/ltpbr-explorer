class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :contact
      t.string :website
      
      t.timestamps
    end
  end
end

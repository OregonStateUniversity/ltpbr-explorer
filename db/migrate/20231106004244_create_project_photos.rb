class CreateProjectPhotos < ActiveRecord::Migration[7.1]
  def up
    create_table :project_photos do |t|
      t.string :description
      t.date :date
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
    add_column :projects, :project_photos_count, :integer, default: 0, null: false
  end

  def down
    remove_column :projects, :project_photos_count
    drop_table :project_photos
  end
end

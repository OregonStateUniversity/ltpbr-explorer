class AddCoverPhotoIdToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :cover_photo_id, :bigint, index: true
    add_foreign_key :projects, :active_storage_attachments, column: :cover_photo_id
  end
end

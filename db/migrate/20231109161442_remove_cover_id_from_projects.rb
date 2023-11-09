class RemoveCoverIdFromProjects < ActiveRecord::Migration[7.1]
  def up
    remove_column :projects, :cover_photo_id
  end

  def down
    add_column :projects, :cover_photo_id, :bigint
    add_foreign_key :projects, :active_storage_attachments, column: :cover_photo_id
  end
end

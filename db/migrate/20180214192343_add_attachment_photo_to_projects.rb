class AddAttachmentPhotoToProjects < ActiveRecord::Migration[5.1]
  def change
    add_attachment :projects, :photo
  end
end

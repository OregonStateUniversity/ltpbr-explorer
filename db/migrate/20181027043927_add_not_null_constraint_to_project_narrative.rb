class AddNotNullConstraintToProjectNarrative < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :narrative, :text, null: false
  end
end

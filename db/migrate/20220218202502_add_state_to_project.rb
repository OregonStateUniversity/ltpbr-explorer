class AddStateToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :state, foreign_key: true
  end
end

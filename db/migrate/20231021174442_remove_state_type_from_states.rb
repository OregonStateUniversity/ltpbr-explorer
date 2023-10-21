class RemoveStateTypeFromStates < ActiveRecord::Migration[7.1]
  def up
    remove_column :states, :state_type
  end

  def down
    add_column :states, :state_type, :string
  end
end

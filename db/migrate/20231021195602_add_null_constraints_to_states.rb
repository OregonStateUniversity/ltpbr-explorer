class AddNullConstraintsToStates < ActiveRecord::Migration[7.1]
  def change
    change_column_null :states, :name, false
    change_column_null :states, :iso_code, false
    change_column_null :states, :geom, false
  end
end

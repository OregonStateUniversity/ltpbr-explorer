class ChangeDateDatatypeFromStringToDate < ActiveRecord::Migration[5.1]
  def change
    change_column :projects, :implementation_date, 'date USING CAST(implementation_date AS date)'
  end
end
class AddNotNullConstraintToProjectColumns < ActiveRecord::Migration[5.1]
  def change
    change_column_null :projects, :affiliation, false
    change_column_null :projects, :stream_name, false
    change_column_null :projects, :implementation_date, false
    change_column_null :projects, :primary_contact, false
  end
end

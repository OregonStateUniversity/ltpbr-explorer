class AddNotNullConstraint < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :affiliation, false
    change_column_null :users, :username, false
    change_column_null :projects, :author_id, false
  end
end

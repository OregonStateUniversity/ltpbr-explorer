class AddNotNullConstraints < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :username, true
    change_column_null :users, :affiliation, true
    change_column_null :projects, :author_id, true
  end
end

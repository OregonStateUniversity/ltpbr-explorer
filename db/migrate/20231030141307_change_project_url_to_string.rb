class ChangeProjectUrlToString < ActiveRecord::Migration[7.1]
  def up
    change_column :projects, :url, :string
  end

  def down
    change_column :projects, :url, :text
  end

end

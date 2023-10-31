class AddProjectsCountToUsers < ActiveRecord::Migration[7.1]
  class Project < ApplicationRecord
    belongs_to :author, class_name: 'User', counter_cache: true
  end
  class User < ApplicationRecord
    has_many :projects, foreign_key: 'author_id', inverse_of: :author
  end

  def up
    add_column :users, :projects_count, :integer, default: 0, null: false
    User.find_each do |user|
      User.reset_counters(user.id, :projects)
    end
  end

  def down
    remove_column :users, :projects_count
  end
end

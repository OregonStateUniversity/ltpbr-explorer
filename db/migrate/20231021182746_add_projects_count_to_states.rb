class AddProjectsCountToStates < ActiveRecord::Migration[7.1]

  class Project < ApplicationRecord
    belongs_to :state, counter_cache: true
  end
  class State < ApplicationRecord
    has_many :projects
  end

  def up
    add_column :states, :projects_count, :integer, default: 0, null: false
    State.find_each do |state|
      State.reset_counters(state.id, :projects)
    end
  end

  def down
    remove_column :states, :projects_count
  end
end

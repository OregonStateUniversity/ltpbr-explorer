class CreateJoinTableProjectsAffiliations < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :affiliations do |t|
      t.index [:project_id, :affiliation_id], unique: true
      # t.index [:affiliation_id, :project_id]
    end
  end
end

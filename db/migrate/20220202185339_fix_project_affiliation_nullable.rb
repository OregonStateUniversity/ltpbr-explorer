class FixProjectAffiliationNullable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :projects, :affiliation_legacy, true
  end
end

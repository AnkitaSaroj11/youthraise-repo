class CleanupAffiliationMess < ActiveRecord::Migration[7.0]
  def change
    remove_index :organizations, :affiliation_name
    remove_column :organizations, :affiliation_name
  end
end

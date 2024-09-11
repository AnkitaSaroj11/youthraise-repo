class AddAffiliationToOrganizations < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :affiliation_name, :string
    add_index :organizations, :affiliation_name
  end
end

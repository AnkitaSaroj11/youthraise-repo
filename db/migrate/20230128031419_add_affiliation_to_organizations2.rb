class AddAffiliationToOrganizations2 < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :affiliation, :string
  end
end

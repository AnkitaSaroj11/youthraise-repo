class AddOrganizationRoleToCampaignMember < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :organization_role, :string
  end
end

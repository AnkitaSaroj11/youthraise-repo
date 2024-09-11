class AddRoleToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :role, :string
    add_index :campaign_members, :role
  end
end

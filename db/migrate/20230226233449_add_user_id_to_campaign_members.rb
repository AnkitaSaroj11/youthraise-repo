class AddUserIdToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :user_id, :integer
    add_index :campaign_members, :user_id
  end
end

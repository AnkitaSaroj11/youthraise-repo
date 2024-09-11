class AddGoalToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :personal_message, :text
  end
end

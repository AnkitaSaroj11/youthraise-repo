class AddGoalAcceptedOnToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :goal_accepted_on, :date
    add_index :campaign_members, :goal_accepted_on
  end
end

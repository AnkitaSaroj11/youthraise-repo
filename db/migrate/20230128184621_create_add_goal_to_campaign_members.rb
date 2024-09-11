class CreateAddGoalToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :individual_goal, :integer
  end
end

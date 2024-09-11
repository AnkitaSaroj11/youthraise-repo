class AddSignupStartedOnToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :signup_started_on, :date
    add_index :campaign_members, :signup_started_on
  end
end

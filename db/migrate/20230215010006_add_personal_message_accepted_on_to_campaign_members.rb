class AddPersonalMessageAcceptedOnToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :personal_message_accepted_on, :date
    add_index :campaign_members, :personal_message_accepted_on
  end
end

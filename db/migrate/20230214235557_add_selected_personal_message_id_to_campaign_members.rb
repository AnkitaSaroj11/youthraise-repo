class AddSelectedPersonalMessageIdToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :selected_personal_message_id, :integer
    add_index :campaign_members, :selected_personal_message_id
  end
end

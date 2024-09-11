class AddInvitationSentOnToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :invitation_sent_at, :datetime
    add_index :campaign_members, :invitation_sent_at
    
    remove_index :campaign_members, :invitation_sent_on
    remove_column :campaign_members, :invitation_sent_on
  end
end

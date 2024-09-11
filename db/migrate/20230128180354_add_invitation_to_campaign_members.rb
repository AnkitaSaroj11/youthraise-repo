class AddInvitationToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :invitation_sent_on, :date
    add_index :campaign_members, :invitation_sent_on
    add_column :campaign_members, :invitation_accepted_on, :date
    add_index :campaign_members, :invitation_accepted_on
  end
end

class AddSelectedEmailTemplateIdToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :selected_email_template_id, :integer
    add_index :campaign_members, :selected_email_template_id
    add_column :organizer_signups, :selected_email_template_id, :integer
    add_index :organizer_signups, :selected_email_template_id
  end
end

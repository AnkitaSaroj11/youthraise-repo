class AddEmailTemplateIdToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :email_template_id, :integer
    add_index :campaign_members, :email_template_id
    add_column :campaign_members, :email_template_accepted_on, :date
  end
end

class AddOrganizationIdToOrganizerSignups < ActiveRecord::Migration[7.0]
  def change
    add_column :organizer_signups, :organization_id, :integer
    add_index :organizer_signups, :organization_id
    add_column :organizer_signups, :campaign_id, :integer
    add_index :organizer_signups, :campaign_id
  end
end

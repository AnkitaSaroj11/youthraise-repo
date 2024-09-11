class AddUuidToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :uuid, :string
    add_index :campaign_members, :uuid
  end
end

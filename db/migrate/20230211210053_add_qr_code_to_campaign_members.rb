class AddQrCodeToCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_members, :qr_code, :text
  end
end

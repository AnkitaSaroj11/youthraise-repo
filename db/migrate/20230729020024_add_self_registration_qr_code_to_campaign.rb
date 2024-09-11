class AddSelfRegistrationQrCodeToCampaign < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :self_registration_qr_code, :text
  end
end

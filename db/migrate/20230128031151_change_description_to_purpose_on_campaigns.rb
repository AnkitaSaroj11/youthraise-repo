class ChangeDescriptionToPurposeOnCampaigns < ActiveRecord::Migration[7.0]
  def change
    rename_column :campaigns, :description, :purpose
  end
end

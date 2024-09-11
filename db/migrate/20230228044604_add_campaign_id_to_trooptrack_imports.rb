class AddCampaignIdToTrooptrackImports < ActiveRecord::Migration[7.0]
  def change
    add_column :troop_track_imports, :campaign_id, :integer
    add_index :troop_track_imports, :campaign_id
    remove_index :troop_track_imports, :organizer_signup_id
    remove_column :troop_track_imports, :organizer_signup_id
  end
end

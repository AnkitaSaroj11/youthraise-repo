class CreateCampaignExports < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_exports do |t|
      t.integer :campaign_id
      t.string :status

      t.timestamps
    end
    add_index :campaign_exports, :campaign_id
    add_index :campaign_exports, :status
  end
end

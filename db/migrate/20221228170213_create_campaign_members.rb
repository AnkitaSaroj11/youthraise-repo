class CreateCampaignMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_members do |t|
      t.integer :role_id
      t.integer :campaign_id
      t.integer :goal
      t.integer :actuals

      t.timestamps
    end
    add_index :campaign_members, :role_id
    add_index :campaign_members, :campaign_id
    add_index :campaign_members, :goal
    add_index :campaign_members, :actuals
  end
end

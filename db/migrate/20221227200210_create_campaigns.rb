class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.integer :organization_id
      t.integer :user_id
      t.integer :goal
      t.integer :actuals
      t.string :name
      t.text :description
      t.date :start_on
      t.date :end_on

      t.timestamps
    end
    add_index :campaigns, :organization_id
    add_index :campaigns, :user_id
    add_index :campaigns, :goal
    add_index :campaigns, :actuals
    add_index :campaigns, :name
    add_index :campaigns, :start_on
    add_index :campaigns, :end_on
  end
end

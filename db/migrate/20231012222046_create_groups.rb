class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :goal
      t.text :registration_qr_code
      t.text :donation_qr_code
      t.integer :campaign_id

      t.timestamps
    end
    add_index :groups, :name
    add_index :groups, :campaign_id
    add_column :campaign_members, :group_id, :integer
    add_index :campaign_members, :group_id 
  end
end

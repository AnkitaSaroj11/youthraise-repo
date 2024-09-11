class CreatePerks < ActiveRecord::Migration[7.0]
  def change
    create_table :perks do |t|
      t.integer :campaign_id
      t.integer :amount
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :perks, :campaign_id
    add_index :perks, :amount
  end
end

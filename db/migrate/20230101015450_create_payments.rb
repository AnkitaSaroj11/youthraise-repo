class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.string :visibility
      t.integer :supporter_id
      t.integer :campaign_member_id

      t.timestamps
    end
    add_index :payments, :amount
    add_index :payments, :supporter_id
    add_index :payments, :campaign_member_id
  end
end

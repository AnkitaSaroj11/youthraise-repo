class CreateSupporters < ActiveRecord::Migration[7.0]
  def change
    create_table :supporters do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :mobile
      t.integer :campaign_member_id

      t.timestamps
    end
    add_index :supporters, :first_name
    add_index :supporters, :last_name
    add_index :supporters, :email
    add_index :supporters, :mobile
    add_index :supporters, :campaign_member_id
  end
end

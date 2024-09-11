class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :campaign_id
      t.text :body
      t.string :subject
      t.date :sent_on
      t.text :recipients
      t.text :delivery_methods
      t.integer :user_id

      t.timestamps
    end
    add_index :messages, :campaign_id
    add_index :messages, :sent_on
    add_index :messages, :user_id
  end
end

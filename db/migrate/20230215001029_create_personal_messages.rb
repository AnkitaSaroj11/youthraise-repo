class CreatePersonalMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :personal_messages do |t|
      t.json :bot_response
      t.integer :templateable_id
      t.string :templateable_type

      t.timestamps
    end
    add_index :personal_messages, :templateable_id
    add_index :personal_messages, :templateable_type
  end
end

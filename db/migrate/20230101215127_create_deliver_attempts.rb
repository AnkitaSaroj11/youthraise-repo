class CreateDeliverAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_attempts do |t|
      t.string :email_status
      t.string :text_status
      t.integer :supporter_id

      t.timestamps
    end

    add_index :delivery_attempts, :supporter_id
  end
end

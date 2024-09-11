class CreateLogins < ActiveRecord::Migration[7.0]
  def change
    create_table :logins do |t|
      t.string :email
      t.string :uuid
      t.string :confirmation_code

      t.timestamps
    end
    add_index :logins, :email
    add_index :logins, :uuid
    add_index :logins, :created_at
  end
end

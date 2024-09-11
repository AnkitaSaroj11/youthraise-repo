class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.integer :user_id
      t.integer :organization_id
      t.string :role

      t.timestamps
    end
    add_index :roles, :user_id
    add_index :roles, :organization_id
  end
end

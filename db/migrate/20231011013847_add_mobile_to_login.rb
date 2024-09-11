class AddMobileToLogin < ActiveRecord::Migration[7.0]
  def change
    add_column :logins, :mobile, :string
    add_index :logins, :mobile
  end
end

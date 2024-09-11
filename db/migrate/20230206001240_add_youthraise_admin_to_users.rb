class AddYouthraiseAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :youthraise_admin, :boolean, default: false
  end
end

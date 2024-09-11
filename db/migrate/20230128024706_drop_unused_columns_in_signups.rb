class DropUnusedColumnsInSignups < ActiveRecord::Migration[7.0]
  def change
    remove_column :organizer_signups, :organization_type
    remove_column :organizer_signups, :role_other
  end
end

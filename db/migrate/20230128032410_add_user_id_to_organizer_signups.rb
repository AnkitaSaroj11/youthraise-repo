class AddUserIdToOrganizerSignups < ActiveRecord::Migration[7.0]
  def change
    add_column :organizer_signups, :user_id, :integer
    add_index :organizer_signups, :user_id
  end
end

class AddCompletedOnToOrganizerSignups < ActiveRecord::Migration[7.0]
  def change
    add_column :organizer_signups, :completed_on, :date
    add_index :organizer_signups, :completed_on
  end
end

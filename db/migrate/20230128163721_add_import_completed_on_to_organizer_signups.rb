class AddImportCompletedOnToOrganizerSignups < ActiveRecord::Migration[7.0]
  def change
    add_column :organizer_signups, :import_completed_on, :date
  end
end

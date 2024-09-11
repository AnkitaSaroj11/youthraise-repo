class CreateOrganizerSignups < ActiveRecord::Migration[7.0]
  def change
    create_table :organizer_signups do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :organization_name
      t.string :organization_type
      t.string :organization_affiliation
      t.string :role_in_organization
      t.string :role_other
      t.integer :goal
      t.string :purpose
      t.string :purpose_other
      t.text :purpose_more_info
      t.date :start_on
      t.date :end_on
      t.string :uuid
      t.date :email_confirmation_on
      t.string :email_confirmation_code

      t.timestamps
    end

    add_index :organizer_signups, :start_on
    add_index :organizer_signups, :uuid
    add_index :organizer_signups, :end_on
    add_index :organizer_signups, :email
    add_index :organizer_signups, :first_name
    add_index :organizer_signups, :last_name
  end
end

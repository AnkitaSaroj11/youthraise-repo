class AddWelcomeEmailToSignups < ActiveRecord::Migration[7.0]
  def change
    add_column :organizer_signups, :email_template_id, :integer
    add_column :organizer_signups, :welcome_email_accepted_on, :date
  end
end

# Preview all emails at http://localhost:3000/rails/mailers/organizer_signup_mailer
class OrganizerSignupMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/organizer_signup_mailer/verify
  def verify
    OrganizerSignupMailer.verify
  end

end

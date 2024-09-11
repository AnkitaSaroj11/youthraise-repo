# Preview all emails at http://localhost:3000/rails/mailers/donation_mailer
class DonationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/donation_mailer/new_donation_for_member
  def new_donation_for_member
    DonationMailer.new_donation_for_member
  end

  # Preview this email at http://localhost:3000/rails/mailers/donation_mailer/new_donation_for_organizer
  def new_donation_for_organizer
    DonationMailer.new_donation_for_organizer
  end

end

# Preview all emails at http://localhost:3000/rails/mailers/member_mailer
class MemberMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/member_mailer/create_your_profile
  def create_your_profile
    MemberMailer.create_your_profile
  end

end

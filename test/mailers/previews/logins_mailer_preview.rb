# Preview all emails at http://localhost:3000/rails/mailers/logins_mailer
class LoginsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/logins_mailer/login_attempt
  def login_attempt
    LoginsMailer.login_attempt
  end

end

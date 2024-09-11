class LoginsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.logins_mailer.login_attempt.subject
  #
  def login_attempt
    @login = params[:login]
    mail to: @login.email, subject: "Login code for YouthRaise.com"
  end
end

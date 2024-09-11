require "test_helper"

class LoginsMailerTest < ActionMailer::TestCase
  test "login_attempt" do
    mail = LoginsMailer.login_attempt
    assert_equal "Login attempt", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

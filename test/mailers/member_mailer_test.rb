require "test_helper"

class MemberMailerTest < ActionMailer::TestCase
  test "create_your_profile" do
    mail = MemberMailer.create_your_profile
    assert_equal "Create your profile", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

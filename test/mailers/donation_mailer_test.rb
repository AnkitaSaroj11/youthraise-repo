require "test_helper"

class DonationMailerTest < ActionMailer::TestCase
  test "new_donation_for_member" do
    mail = DonationMailer.new_donation_for_member
    assert_equal "New donation for member", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "new_donation_for_organizer" do
    mail = DonationMailer.new_donation_for_organizer
    assert_equal "New donation for organizer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

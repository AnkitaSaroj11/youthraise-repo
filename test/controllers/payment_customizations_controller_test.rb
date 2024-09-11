require "test_helper"

class PaymentCustomizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get payment_customizations_edit_url
    assert_response :success
  end
end

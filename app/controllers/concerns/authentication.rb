module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
    helper_method :current_user
    helper_method :user_signed_in?
  end

  def login(user)
    reset_session
    session[:current_user_id] = user.id
    set_session_expiry
  end

  def login_payment(payment)
    session[:current_payment_id] = payment.id
    set_session_expiry
  end

  def logout
    reset_session
  end

  def redirect_if_authenticated
    redirect_to root_path, alert: "You are already logged in." if user_signed_in?
  end

  private

  def current_user
    return nil if session[:expires_at].nil?
    return nil if session[:expires_at].to_datetime < DateTime.now
    set_session_expiry
    Current.user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def current_payment
    return nil if session[:expires_at].nil?
    return nil if session[:expires_at].to_datetime < DateTime.now
    set_session_expiry
    Current.payment ||= session[:current_payment_id] && Payment.find(session[:current_payment_id])
  end

  def set_session_expiry
    session[:expires_at] = DateTime.now + Rails.application.config.x.session_expires_in
  end

  def user_signed_in?
    Current.user.present?
  end

  def payment_signed_in?
    current_payment.present?
  end

  def session_active?

  end

  def user_signed_in_as_admin?
    Current.user.present? && Current.user.is_youthraise_admin?
  end

end
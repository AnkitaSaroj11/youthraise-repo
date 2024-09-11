class Login < ApplicationRecord
  validates :email, presence: true, unless: :mobile
  validates :mobile, presence: true, unless: :email

  before_create :generate_login_confirmation_code
  before_create :generate_uuid
  
  scope :active, -> { where('created_at > ?', DateTime.now - Rails.application.config.login_expires_after) }

  attr_accessor :confirmation_code_attempt

  def user
    if email
      User.where(email: email).first
    else
      User.where(mobile: mobile).first
    end
  end

  def send_confirmation_code_text
    sns = Aws::SNS::Client.new(
      region: 'us-east-1', 
      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id), 
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
    )
    sns.publish(
      phone_number: "+1#{mobile}", 
      message: confirmation_code_message
    )
  end

  private

  def confirmation_code_message
    "Your YouthRaise.com confirmation code is #{confirmation_code}."
  end

  def generate_uuid
    self.uuid ||= loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless Login.exists?(uuid: random_token)
    end
  end

  def generate_login_confirmation_code
    self.confirmation_code = "%06d" % SecureRandom.random_number(999999)
  end

end

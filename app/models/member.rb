class Member
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :first_name, :last_name, :email, :register_by_email, :accept_text_messages, :mobile, :organization, :user, :role

  validates :first_name, :last_name, presence: true
  validates :mobile, :accept_text_messages, presence: true, unless: :email
  validates :email, presence: true, unless: :mobile

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def save
    if valid?
      if register_by_email
        self.user = User.find_or_create_by(email: email)
      else
        self.user = User.find_or_create_by(mobile: mobile)
      end
      self.user.update(
        last_name: last_name, 
        first_name: first_name, 
        mobile: mobile,
        email: email
      )
      
      return true
    else
      false
    end
  end

  def persisted?
    false
  end
end
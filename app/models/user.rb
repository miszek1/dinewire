class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :meals
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages

  before_save :ensure_authentication_token
  before_create :ensure_authentication_token

  def full_name
    "#{first_name} #{last_name}" 
  end

private

def ensure_authentication_token
  if self.authentication_token.nil?
    self.authentication_token = SecureRandom.urlsafe_base64(nil,false)
  end
end

end


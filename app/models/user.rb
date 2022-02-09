class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true
  validates :name, presence: true
validates :password, presence: true
validates :password_confirmation, presence: true, length: { minimum: 5 }
validates_uniqueness_of :email, :case_sensitive => false

def self.authenticate_with_credentials(email,password)
  user = User.find_by_email(email)
  
  # If the user exists AND the password entered is correct.
  if user && user.authenticate(password)
      return user
  else
      return nil
  end
end
end
class User < ActiveRecord::Base
  
  has_secure_password
  before_save { self.email = email.downcase }
  valid_email_exp = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: valid_email_exp }, uniqueness: { case_sensitive: false }
  validates :password, length: { within: 6..40 }

end

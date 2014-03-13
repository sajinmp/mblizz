class User < ActiveRecord::Base
  
  before_save { self.email = email.downcase }
  valid_email_exp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: valid_email_exp }, uniqueness: { case_sensitive: false }
  #has_secure_password
  
end

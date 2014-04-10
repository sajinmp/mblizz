class User < ActiveRecord::Base
  
  has_secure_password
  before_save { self.email = email.downcase }
  
  before_create :create_remember_token
  
  valid_email_exp = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { within: 4..20 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: valid_email_exp }, uniqueness: { case_sensitive: false }
  validates :password, length: { within: 6..40 }
  validates :sex, presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end

end

class User < ActiveRecord::Base

  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  #set the session token before validation if it isn't present
  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end

  def password=(password)
    @password = password #review; why is instance var needed??
    self.password_digest = BCrypt::Password.create(password)
  end

  #WHY DOES THIS NEED TO BE HERE FOR LOGIN TO WORK?
  def password_digest
    BCrypt::Password.new(super)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)

    return nil if user.nil?

    user.password_digest.is_password?(password) ? user : nil
  end

end

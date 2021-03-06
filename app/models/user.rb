class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  attr_reader :password

  before_validation :ensure_session_token

  has_many :subs,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: "Sub"

  has_many :posts,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "Post"

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil if user.nil?

    if user.is_password?(password)
      user
    else
      nil
    end
  end

  def password= password
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def is_password? password
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save
    self.session_token
  end

end

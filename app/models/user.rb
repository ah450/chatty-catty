class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # Generates a timed JWT
  # expiration unit is hours
  # default is 1 hour
  def token(expiration=1)
    payload = {
      data: {
        id: id,
        discriminator: password_digest
        # discriminator used to detect password changes after token generation
      },
      exp: Time.now.to_i + expiration * 60 * 60
    }
    # HMAC using SHA-512 algorithm
    JWT.encode payload, User.hmac_key, 'HS512'
  end

  # Retrieve user based on token
  # Raises JWT::VerificationError if key missmatch or signature corrupted
  # Raises JWT::ExpiredSignature
  # Both subclasses of JWT::DecodeError
  # Raises ActiveRecord::RecordNotFound if user no longer exists
  # Raises AuthenticationError if incorrect authentication data supplied
  # returns user
  def self.find_by_token(token)
    decoded = JWT.decode token, hmac_key, true, {leeway: 60}
    data = decoded.first['data']
    user = find data['id']
    raise AuthenticationError unless Rack::Utils.secure_compare(
      user.password_digest, data['discriminator'])
    return user
  end

  def as_json(options={})
    super(except: [:password_digest])
  end

  private

  def self.hmac_key
    Rails.application.config.jwt_key
  end
end

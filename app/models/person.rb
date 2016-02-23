class Person < ActiveRecord::Base
  attr_accessor :remember_token
  
  # Validates that all requried text is entered.
  before_save { email.downcase! }
  # Downcases email before saving to the database
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: {maximum: 255}, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name,  presence: true, length: { maximum: 60}
  has_secure_password
  # Enforces validations on the virtual attributes password
  # and password_confirmation
  validates :password, presence: true, length: {minimum: 6}
  
  # Returns the hash digest of the given string.
  def Person.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token. This is the user's remember token.
  def Person.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Person.new_token
    # Generates a remember token for the current user.
    update_attribute(:remember_digest, Person.digest(remember_token))
    # Saves the hash digest of the token in the database.
  end
  
  # Returns true if the given token matches the digest in the database.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # ActiveRecord knows that remember_digest is referring to a model attribute.
  end
  
  # Forgets a user by setting his remember digest to nil in the database.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end

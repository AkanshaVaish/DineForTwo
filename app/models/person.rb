class Person < ActiveRecord::Base
  # Virtual attributes don't have a column in the database.
  attr_accessor :remember_token, :activation_token, :reset_token
  
  # Callbacks defined via method references.
  before_save :downcase_email
  before_create :create_activation_digest

  # Validates that all requried text is entered.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: {maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name,  presence: true, length: { maximum: 60}
  has_secure_password
  # Enforces validations on the virtual attributes password
  # and password_confirmation.
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  # allow_nil allows an exception to be made for an empty password field
  # when updating a Person profile.

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
  def authenticated?(digest, token)
    digest = send("#{digest}_digest")
    # Use metaprogramming to select the appropriate token attribute based on 
    # the parameter digest.
    return false if digest.nil? # Digest does not exist in the database.
    BCrypt::Password.new(digest).is_password?(token)
    # Decrypts the digest and compares it to the token.
  end

  # Forgets a user by setting his remember digest to nil in the database.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = Person.new_token
    update_attribute(:reset_digest,  Person.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Parses the OAuth authentication hash and writes values to a Person object
  # in the database.
  class << self
    def from_omniauth(auth_hash)
      person = find_or_create_by(uid: auto_hash['uid'])
      person.name = auto_hash['info']['name']
      person.image_url = auto_hash['info']['image']
      person.url = auto_hash['info']['urls']['Facebook']
      person.save!
      person
    end
  end
  
  private
  
  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end
  
  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = Person.new_token
    self.activation_digest = Person.digest(activation_token)
  end

end

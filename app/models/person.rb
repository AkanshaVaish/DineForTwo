class Person < ActiveRecord::Base

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

end

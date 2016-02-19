class Person < ActiveRecord::Base



  #Make an attribute accessor for password
  attr_accessor :password
  attr_accessor :password_salt
  before_save :encrypt_password

  #validate that the password confirmation (do they match?) is present
  validates_confirmation_of :password

  #validates that all requried text is entered

  validates_presence_of :password, :on => :create

  validates :email, presence: true,
                    length: {minimum: 7}
  validates_uniqueness_of :email
  validates :name,  presence: true,
                    length: {minimum: 5, maximum: 12}
  validates_uniqueness_of :name

  def self.authenticate(name, password)
    person = find_by_name(name)
    if person && person.password_hash == BCrypt::Engine.hash_secret(password, person.password_salt)
      person
    else
      nil
    end
  end
  #encrypts the password the user enters
  def encrypt_password
    if password.present?
      #salt is a type of encryption that ruby has for passwords
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end



end

class Person < ActiveRecord::Base

  #validates that all requried text is entered

  validates :email, presence: true,
                    length: {minimum: 7}
  validates_uniqueness_of :email
  validates :name,  presence: true,
                    length: {minimum: 2, maximum: 12}
  validates_uniqueness_of :name
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

end

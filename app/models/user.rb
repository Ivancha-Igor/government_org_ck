class User < ActiveRecord::Base
  has_secure_password
  validates :password,
            length: { minimum: 6 }
  validates :email,
            presence: true,
            uniqueness: true
  validates :name,
            presence: true,
            length: { maximum: 50 }
end

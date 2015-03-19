# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password
  has_many :comments, dependent: :destroy

  after_save { self.email = email.downcase if provider == 'twitter' }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :password,
            length: { minimum: 6 }
  validates :email,
            presence: true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false },
            allow_blank: true
  validates :name,
            presence: true,
            length: { maximum: 50 }

  require 'securerandom'
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.password = SecureRandom.urlsafe_base64
    end
  end
end

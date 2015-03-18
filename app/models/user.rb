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

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :password,
            length: { minimum: 6 },
            allow_nil: true
  validates :email,
            presence: true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false },
            allow_blank: true
  validates :name,
            presence: true,
            length: { maximum: 50 }

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
    end
  end
end

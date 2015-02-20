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
  validates :password,
            length: { minimum: 6 }
  validates :email,
            presence: true,
            uniqueness: true
  validates :name,
            presence: true,
            length: { maximum: 50 }
end

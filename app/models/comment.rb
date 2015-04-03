# == Schema Information
#
# Table name: comments
#
#  id              :integer          not null, primary key
#  body            :text
#  user_id         :integer
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ancestry        :string
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_ancestry

  validates_presence_of :body
  validates :body, obscenity: { sanitize: true, replacement: :garbled }

  after_create :update_organization
  def update_organization
    self.organization.touch
  end
end

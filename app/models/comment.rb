class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_ancestry

  validates_presence_of :body

  after_create :update_organization
  def update_organization
    self.organization.touch
  end
end

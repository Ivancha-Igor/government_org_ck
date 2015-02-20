# == Schema Information
#
# Table name: organization_tags
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  tag_id          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class OrganizationTag < ActiveRecord::Base
  belongs_to :organization
  belongs_to :tag
end

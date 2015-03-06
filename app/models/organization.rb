# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  address     :string
#  phone       :string
#  email       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Organization < ActiveRecord::Base
  has_many :organization_tags
  has_many :tags, through: :organization_tags

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).organizations
  end

  scope :search, -> search { joins(:tags).where('title LIKE ? OR tags.name LIKE ?', "%#{search}%", "%#{search}%").uniq}
end

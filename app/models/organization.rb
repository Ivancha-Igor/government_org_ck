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
#  latitude    :float
#  longitude   :float
#

class Organization < ActiveRecord::Base
  has_many :organization_tags, dependent: :destroy
  has_many :tags, through: :organization_tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title,
            presence: true,
            uniqueness: true
  validates :address,
            presence: true
  validates_presence_of :slug

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  translates :title, :description, :address, :slug
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :globalize]

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def to_param
    "#{id} #{title}".parameterize
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def self.tagged_with(tag)
    Tag.find_by_id!(tag).organizations
  end

  scope :search, -> search { joins(:tags).where('title LIKE ? OR tags.name LIKE ?', "%#{search}%", "%#{search}%").uniq}
end

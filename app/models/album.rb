class Album < ActiveRecord::Base
  attr_accessible :name, :public, :slug, :user_id

  belongs_to :user
  has_many :photos

  scope :overview, -> { order('created_at asc') }

  validates :user, :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  def cover
    photos.first.image.large_thumb.url
  end
end

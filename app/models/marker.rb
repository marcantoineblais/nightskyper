class Marker < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates :user, :title, :description, presence: true
  validates :latitude, :longitude, uniqueness: true, presence: true

  scope :find_by_coordinates, ->(long, lat) { where('longitude = ? AND latitude = ?', long, lat) }

  def ratings
    reviews.map(&:rating)
  end

  def average_rating
    (ratings.sum.to_f / ratings.count).round(1)
  end
end

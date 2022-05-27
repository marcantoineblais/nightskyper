class Marker < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :photo

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates :user, :title, :description, presence: true
  validates :latitude, :longitude, uniqueness: true, presence: true

  scope :find_by_coordinates, ->(long, lat) { where('longitude = ? AND latitude = ?', long, lat) }
end

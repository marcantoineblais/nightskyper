class Marker < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :favorites
  has_one_attached :photo

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates :user, :title, :description, presence: true
  validates :latitude, :longitude, uniqueness: true, presence: true
end

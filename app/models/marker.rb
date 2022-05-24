class Marker < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :favorites
  has_one_attached :photo

  validates :user, :title, :description, presence: true
  validates :latitude, :longitude, uniqueness: true, presence: true
end

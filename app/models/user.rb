class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def favorite_markers
    favorites.map(&:marker)
  end
end

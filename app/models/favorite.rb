class Favorite < ApplicationRecord
  belongs_to :marker
  belongs_to :user

  validates :marker, :user, presence: true
  validates :marker, uniqueness: { scope: :user, message: "Already in your favorites" }
end

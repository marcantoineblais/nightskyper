class Review < ApplicationRecord
  belongs_to :user
  belongs_to :marker
  has_one_attached :photo

  validates :user, :marker, :rating, :content, :date, presence: true
  validates :marker, uniqueness: { scope: :user, message: "Already left comment before" }
end

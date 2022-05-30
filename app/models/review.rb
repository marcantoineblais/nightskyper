class Review < ApplicationRecord
  belongs_to :user
  belongs_to :marker, dependent: :destroy
  has_many_attached :photos

  validates :user, :marker, :rating, :content, :date, presence: true
  # validates :marker, uniqueness: { scope: :user, message: "Already left comment before" }
end

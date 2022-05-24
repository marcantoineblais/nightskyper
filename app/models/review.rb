class Review < ApplicationRecord
  belongs_to :user
  belongs_to :marker
  has_one_attached :photo

end

class Favorite < ApplicationRecord
  belongs_to :marker
  belongs_to :user
end

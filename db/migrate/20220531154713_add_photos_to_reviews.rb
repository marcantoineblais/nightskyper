class AddPhotosToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :photos, :string
  end
end

class AddPhotoToMarkers < ActiveRecord::Migration[6.1]
  def change
    add_column :markers, :photo, :string
  end
end

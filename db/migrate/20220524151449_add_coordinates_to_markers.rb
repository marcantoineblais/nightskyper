class AddCoordinatesToMarkers < ActiveRecord::Migration[6.1]
  def change
    add_column :markers, :latitude, :float
    add_column :markers, :longitude, :float
  end
end

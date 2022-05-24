class AddAddressToMarkers < ActiveRecord::Migration[6.1]
  def change
    add_column :markers, :address, :string
  end
end

class CreateMarkers < ActiveRecord::Migration[6.1]
  def change
    create_table :markers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end

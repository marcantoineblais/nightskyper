class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :marker, null: false, foreign_key: true
      t.integer :rating
      t.string :content
      t.date :date

      t.timestamps
    end
  end
end

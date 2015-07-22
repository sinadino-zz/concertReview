class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :artist
      t.string :venue
      t.date :date
      t.string :genre
      t.integer :sound
      t.integer :stagePresence
      t.integer :songSelection
      t.integer :overallRating
      t.string :comments
      t.belongs_to :concert
      t.belongs_to :user

      t.timestamps
    end
  end
end

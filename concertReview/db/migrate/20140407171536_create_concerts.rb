class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|

      t.string :venue
      t.date :date
      t.belongs_to :artist

      t.timestamps
    end
  end
end

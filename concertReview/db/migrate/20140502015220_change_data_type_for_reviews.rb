class ChangeDataTypeForReviews < ActiveRecord::Migration
  def self.up
  	change_table :reviews do |t|
      t.change :comments, :text
    end
  end
  def self.down
  	change_table :reviews do |t|
      t.change :comments, :string
    end
  end
end

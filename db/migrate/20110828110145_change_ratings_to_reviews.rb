class ChangeRatingsToReviews < ActiveRecord::Migration
  def self.up
    rename_table :ratings, :reviews
    add_column :reviews, :text, :string
  end

  def self.down
    rename_table :reviews, :ratings
    remove_column :ratings, :text
  end
end

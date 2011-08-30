class AddNameToReview < ActiveRecord::Migration
  def self.up
    add_column :reviews, :name, :string
  end

  def self.down
    remove_column :ratings, :name
  end
end

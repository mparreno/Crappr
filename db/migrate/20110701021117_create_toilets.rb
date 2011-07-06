class CreateToilets < ActiveRecord::Migration
  def self.up
    create_table :toilets do |t|
      t.string :name 
      t.boolean :change_rm, :default => false
      t.string :gender 
      t.boolean :disabled, :default => false
      t.string :open_hours 
      t.string :location 
      t.float :lat 
      t.float :lng
      
      t.integer  :suburb_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :toilets
  end
end
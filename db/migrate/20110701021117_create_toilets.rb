class CreateToilets < ActiveRecord::Migration
  def self.up
    create_table :toilets do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :toilets
  end
end

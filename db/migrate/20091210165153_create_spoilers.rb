class CreateSpoilers < ActiveRecord::Migration
  def self.up
    create_table :spoilers do |t|
      t.references :user
      t.text :name

      t.timestamps
    end
  end

  def self.down
    drop_table :spoilers
  end
end

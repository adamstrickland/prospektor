class CreateCallbacks < ActiveRecord::Migration
  def self.up
    create_table :callbacks do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :callbacks
  end
end

class CreatePresentations < ActiveRecord::Migration
  def self.up
    create_table :presentations do |t|
      t.string :email, :null => false
      t.string :url, :null => false
      t.references :lead, :null => false
      t.references :user, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :presentations
  end
end

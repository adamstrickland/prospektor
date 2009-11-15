class AddPhoneNumberToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :phone, :string, :null => false, :default => "2143610080"
    add_column :users, :extension, :string
    add_column :users, :mobile, :string
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :extension
    remove_column :users, :mobile
  end
end

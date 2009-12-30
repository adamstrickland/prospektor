class TweakLeadsTableColumnSettings < ActiveRecord::Migration
  def self.up
    change_column :leads, :name, :string, :null => false
    change_column :leads, :company, :string, :null => false
    change_column :leads, :phone, :string, :null => false
    
    add_index :leads, :name
    add_index :leads, :phone, :unique => true
    add_index :leads, :company
    add_index :leads, :state
    add_index :leads, :timezone
  end

  def self.down
    remove_index :leads, :name
    remove_index :leads, :phone
    remove_index :leads, :company
    remove_index :leads, :state
    remove_index :leads, :timezone
    
    change_column :leads, :name, :string, :null => true
    change_column :leads, :company, :string, :null => true
    change_column :leads, :phone, :string, :null => true
  end
end

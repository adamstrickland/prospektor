class AddStiToStatuses < ActiveRecord::Migration
  def self.up
    add_column :statuses, :type, :string
    
    Status.reset_column_information
    
    Status.all.each do |s|
      s.type = "#{s.context.camelize}Status"
      s.context = nil
      s.save
    end
    
    change_column :statuses, :type, :string, :null => false
    add_index :statuses, :type
  end

  def self.down
    Status.all.each do |s|
      s.context = s.type.chomp("Status")
      s.save
    end
    
    remove_column :statuses, :type, :string
  end
end

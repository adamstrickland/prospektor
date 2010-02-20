class AddSomeIndexes < ActiveRecord::Migration
  def self.indexes
    [  
      { :table => :leads, :columns => [:status_id] },
      { :table => :leads, :columns => [:last_name] },
      { :table => :leads_users, :columns => [:user_id] },
      { :table => :leads_users, :columns => [:lead_id] },
      { :table => :statuses, :columns => [:state] },
      { :table => :statuses, :columns => [:code] },
      { :table => :users, :columns => [:employee_id] },
    ]
  end
  
  def self.up
    self.indexes.each do |hash|
      hash[:options] ||= {}
      add_index hash[:table], hash[:columns], hash[:options]
    end
  end

  def self.down
    self.indexes.each do |hash|
      drop_index hash[:table], :column => hash[:columns]
    end
  end
end

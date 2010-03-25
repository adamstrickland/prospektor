class AddEditorAndContributorRoles < ActiveRecord::Migration
  def self.up
    editor = Role.new(:name => 'editor').save
    contributor = Role.new(:name => 'contributor').save
    
    
  end

  def self.down
  end
end

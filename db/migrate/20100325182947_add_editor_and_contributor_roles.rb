class AddEditorAndContributorRoles < ActiveRecord::Migration
  def self.up
    editor, contributor = ['editor', 'contributor'].map{|t| r = Role.new(:title => t); r.save; r}
    
    editors = ['jalmand', 'gniblack', 'adam.strickland']
    
    editors.each do |l|
      u = User.find_by_login(l)
      u.roles << editor
      u.save
    end
    (editors + ['cgoodbread','bsnellman','mwesson']).each do |l|
      u = User.find_by_login(l)
      u.roles << contributor
      u.save
    end
  end

  def self.down
    ['editor','contributor'].each do |t|
      r = Role.find_by_title(t)
      r.destroy
    end
  end
end

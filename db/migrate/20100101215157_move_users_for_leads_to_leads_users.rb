class MoveUsersForLeadsToLeadsUsers < ActiveRecord::Migration
  module Old
    class Lead < ActiveRecord::Base
      set_table_name :leads
      belongs_to :user
      # belongs_to :user, :class => MoveUsersForLeadsToLeadsUsers::OldUser
    end
    class User < ActiveRecord::Base
      set_table_name :users
      has_many :leads
      # has_many :leads, :class => MoveUsersForLeadsToLeadsUsers::OldLead
    end
  end
  module New
    class Lead < ActiveRecord::Base
      set_table_name :leads
      has_and_belongs_to_many :users, :join_table => 'leads_users', :association_foreign_key => 'user_id'
    end
    class User < ActiveRecord::Base
      set_table_name :users
      has_and_belongs_to_many :leads, :join_table => 'leads_users', :association_foreign_key => 'lead_id'
    end
  end
  
  def self.up
    # Old::Lead.find(:all, :conditions => ['user_id IS NOT NULL']).each do |ol|
    #   nl = New::Lead.find(ol.id)
    #   nl.users << New::User.find(ol.user.id)
    #   nl.save
    # end
  end

  def self.down
    # New::User.find(:all).each do |nu|
    #   nu.leads.each do |nl|
    #     ol = Old::Lead.find(nl.id)
    #     ol.user = Old::User.find(nu.id)
    #     ol.save
    #   end
    # end
  end
end

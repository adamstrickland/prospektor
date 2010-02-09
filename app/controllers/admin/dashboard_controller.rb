class Admin::DashboardController < ApplicationController
  layout 'admin'
  
  access_control :DEFAULT => 'admin'
  
  def index
    activity_for_period = lambda do |start, finish|
      
    end
    
    logins_since = lambda do |range|
      Event.find(:all, :conditions => {:action => 'login', :qualifier => 'success', :created_at => range}).count
    end
    
    @activity = {
      :today => logins_since.call((Time.now.midnight.gmtime - 1.day)..Time.now.midnight.gmtime),
      :week_to_date => logins_since.call((Time.now.midnight.gmtime - (Time.now.wday).day)..Time.now.midnight.gmtime),
      :month_to_date => logins_since.call(Time.local(Time.now.year, Time.now.month).gmtime..Time.now.midnight.gmtime),
      :year_to_date => logins_since.call(Time.local(Time.now.year).gmtime..Time.now.midnight.gmtime)
    }
  end
end

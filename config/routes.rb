ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.session_expiry '/expires', :controller => 'sessions', :action => 'session_expiry'
  map.resource :session
  
  map.wiki_root '/wiki'
  map.wiki_pages '/wiki/all', :controller => 'wiki_pages', :root => '/wiki', :action => 'all'
  # map.with_options :controller => 'wiki_pages', :path_prefix => '/wiki', :root => '/wiki' do |wiki|
  #   wiki.wiki_pages 'all', :action => 'all', :conditions => {:method => :get }
  #   wiki.edit_wiki_page 'edit/:path', :action => 'edit', :conditions => {:method => :get }
  #   wiki.wiki_page ':path', :action => 'show', :conditions => {:method => :get}
  #   wiki.wiki_page_history 'history/:path', :action => 'history', :conditions => {:method => :get }
  #   wiki.wiki_page_compare 'compare/:path', :action => 'compare', :conditions => {:method => :get }
  #   
  #   wiki.new_wiki_page 'new', :action => 'new', :conditions => {:method => :get }
  #   wiki.create_wiki_page 'create', :action => 'create', :conditions => {:method => :post }
  #   wiki.destroy_wiki_page ':path', :action => 'destroy', :conditions => {:method => :delete }
  #   wiki.update_wiki_page ':path', :action => 'update', :conditions => {:method => :put }
  # end
  
  map.with_options :controller => 'dashboard' do |opts|
    opts.dashboard '/dashboard', :action => 'index'
    opts.terms '/terms', :action => 'terms'
  end

  map.resources :call_backs, :as => 'callbacks', :only => [ :update ]
  map.resources :users do |users|
    # users.call_manager 'cm', :controller => 'call_manager', :action => 'next'
    users.call_manager 'cm', :controller => 'leads', :action => 'call_manager'

    users.resources :leads, :only => [ :index, :show ], :collection => { :empty => :get }
    users.resources :call_backs, :as => 'callbacks', :only => [ :index ]
    
    
    
    # users.resources :call_queues, :as => 'queues', :only => [ :create ], :member => { :empty => :get } do |cq|
    #   cq.resources :touchpoints, :as => 'calls', :only => [ :show ]
    # end
    users.resources :reports, :only => [ :index, :show ]
    users.profile 'profile', :controller => 'users', :action => 'show'
  end
  # map.search '/search', :controller => 'search', :action => 'show'
  map.resources :search, :only => [:new, :index]
  
  map.lead_by_phone '/leads/phone/:phone.:format', :controller => 'leads', :action => 'find_by_phone'
  map.resources :leads, :member => { :demographics => :get, :history => :get, :details => :get } do |leads|
    leads.resources :comments, :only => [ :new, :create, :index ]
    leads.resources :events, :only => [ :index ]
    # leads.resources :events, :only => [ :new, :create, :index ]
    
    # TODO: should move these to :member methods    
    leads.resources :presentations, :only => [ :new, :create ]
    leads.resources :appointments, :only => [ :new, :create ]
    leads.resources :disposition, :only => [ :new, :create ]
  end
  
  map.namespace :admin do |admin|
    admin.dashboard 'dashboard', :controller => 'dashboard', :action => 'index'
    admin.resources :users, :only => [ :index ], :member => { :reset_password => :post, :deactivate => :post } do |user|
      user.with_options :controller => 'assignments' do |opts|
        opts.bulk_assignment 'bulk', :action => 'bulk'
      end
      user.resources :assignments do |assignment|
      end
    end 
    admin.resources :applicants, :only => [ :index ], :member => { :onboard => :post, :reject => :post }
  end 
  
  map.with_options :path_prefix => 'public' do |pub|
    pub.resources :mockups, :only => [:index, :show]
    pub.with_options :name_prefix => 'survey_', :controller => 'surveyor', :conditions => { :method => :get } do |surveys|
      surveys.bcr 'bcr', :action => 'get_bcr'
      surveys.results ':response_set_code/results.:format', :action => 'results'
      surveys.unknown 'unknown', :action => 'unknown'
    end
    pub.with_options :name_prefix => 'video_', :path_prefix => 'public/videos', :controller => 'videos', :conditions => { :method => :get } do |videos|
      videos.bcr 'bcr.:format', :action => 'bcr'
    end
    pub.resources :applicants, :only => [:new, :create], :collection => { :thanks => :get }
  end
  
  map.welcome '/welcome', :controller => 'welcome', :action => 'index'
  
  map.pdf '/assets/:asset', :controller => 'help', :action => 'pdf'
  
  ['quick_start', 'users_guide', 'documentation', 'faq', 'sales_aides'].each do |act|
    map.send(act, "/docs/#{act}", :controller => 'help', :action => act)
  end
  
  map.with_options :controller => 'application' do |err|
    err.error '/500', :action => 'error'
    err.not_found '/404', :action => 'not_found'
  end
  
  map.root :controller => "welcome"
  
  map.connect '*', :controller => 'application', :action => 'not_found' unless ::ActionController::Base.consider_all_requests_local
end

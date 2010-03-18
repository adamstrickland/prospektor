ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.session_expiry '/expires', :controller => 'sessions', :action => 'session_expiry'
  map.resource :session
  
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
  map.search '/search', :controller => 'search', :action => 'show'
  
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
        opts.search_assignments 'search', :action => 'search'
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
  
  ['quick_start', 'users_guide', 'documentation', 'faq', 'search', 'sales_aides'].each do |act|
    map.send(act, "/docs/#{act}", :controller => 'help', :action => act)
  end
  
  map.with_options :controller => 'application' do |err|
    err.error '/500', :action => 'error'
    err.not_found '/404', :action => 'not_found'
  end
  
  map.root :controller => "welcome"
  
  map.connect '*', :controller => 'application', :action => 'not_found' unless ::ActionController::Base.consider_all_requests_local
end

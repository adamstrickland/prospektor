ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.resource :session

  map.resources :users do |users|
    # users.resources :call_queues, :only => [ :create, :index, :show ] do |cq|
    users.resources :call_queues, :as => 'queues', :only => [ :create ], :member => { :empty => :get } do |cq|
      cq.resources :touchpoints, :as => 'calls', :only => [ :show ]
    end
    
    users.resources :reports, :only => [ :index, :show ]
    
    users.dashboard '/dashboard', :controller => 'dashboard', :action => 'index'
    users.terms '/terms', :controller => 'dashboard', :action => 'terms'
  end
  
  map.lead_by_phone '/leads/phone/:phone.:format', :controller => 'leads', :action => 'find_by_phone'
  map.resources :leads, :member => { :next => :get, :demographics => :get } do |leads|
    # leads.phone 'phone/:phone', :controller => 'leads', :action => 'find_by_phone'
    leads.resources :presentations, :only => [ :new, :create ]
    leads.resources :appointments, :only => [ :new, :create ]
    leads.resources :comments, :only => [ :new, :create ]
    leads.resources :events, :only => [ :new, :create, :index ]
    leads.resources :disposition, :only => [ :new, :create ]
    leads.resources :suspend, :only => [ :new, :create ]
  end
  
  map.namespace :admin do |admin|
    admin.dashboard 'dashboard', :controller => 'dashboard', :action => 'index'
  end 
  
  map.welcome '/welcome', :controller => 'welcome', :action => 'index'
  
  map.pdf '/assets/:asset', :controller => 'help', :action => 'pdf'
  
  ['quick_start', 'users_guide', 'documentation', 'faq', 'search', 'sales_aides'].each do |act|
    map.send(act, "/docs/#{act}", :controller => 'help', :action => act)
  end  

  # map.resources :events

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end

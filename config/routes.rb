ActionController::Routing::Routes.draw do |map|

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
  # map.root :controller => "welcome"
  
  # See how all your routes lay out with "rake routes"
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  
  map.root :controller => "extensions"
   
  map.resources :extensions, :collection => {:rss => :get} do |extensions|
    extensions.resources :comments
    extensions.resources :ratings     
  end
  
  map.resources :tags
  map.resources :categories

  
  map.resource :account, :controller => "users"
  map.resources :users
  
  map.resource :user_session
  map.logout '/user_session/destroy', :controller => 'user_sessions', :action => 'destroy'
  
  map.namespace(:admin) do |admin|
    admin.resources :extensions, :comments, :users, :tags, :categories
  end
  
  map.toggle_comments 'toggle_comments/:id', :controller => "extensions", :action => "toggle_comments" 
  map.list_tags 'list_tags', :controller => "tags", :action => "list_tags" 
  map.add_tags_to_field 'add_tags_to_field/:id', :controller => "tags", :action => "add_tags_to_field" 
  map.create_comment 'create_comment', :controller => "comments", :action => "create" 
  map.show_by_tag 'show_by_tag/:id', :controller => "extensions", :action => "show_by_tag"
  map.show_by_rating 'show_by_rating', :controller => "extensions", :action => "show_by_rating"
  map.add_rating 'rate/:id', :controller => "ratings", :action => "add"
  map.show_by_category 'show_by_category/:id', :controller => "extensions", :action => "show_by_category"
  map.show_impressum 'impressum', :controller => "staticsites", :action => "impressum"
  map.redirect_to_blog 'blog', :controller => "staticsites", :action => "blog"
  map.preview 'preview/:id', :controller => "extensions", :action => "preview"
  map.plain_list 'plain_list', :controller => "extensions", :action => "plain_list"
  map.nice_extension 'extension/:id/:name', :controller => "extensions", :action => "show"
  
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  
end

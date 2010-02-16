ActionController::Routing::Routes.draw do |map|
  map.resources :posts, :as => "blog" do |post|
    post.resources :comments
  end
  map.resources :site
  map.resources :archive
  map.resources :tags
  map.resources :search
  map.resources :scratches
  map.resources :sessions

  map.namespace :admin do |admin|
    admin.resources :posts
  end

  map.root :controller => "posts"

  map.blog "blog", :controller => "posts"

  map.about    "about",       :controller => "site", :action => "show"
  map.contact  "contact",     :controller => "site", :action => "new"
  map.services "services",    :controller => "site"
  map.connect  "sitemap.xml", :controller => "site", :format => "xml"

  map.cloud "cloud", :controller => "tags", :action => "index"

  map.archive_by_year_and_month "archive/:year/:month/", :controller => "archive"

  map.permalink "blog/:permalink", :controller => "posts", :action => "show"

  map.login  "login",  :controller => "sessions", :action => "new"
  map.logoff "logoff", :controller => "sessions", :action => "destroy"

  map.connect ":controller/:action/:id"
  map.connect ":controller/:action/:id.:format"

  map.connect "*path", :controller => "sessions", :action => "show", :status => "404"
end

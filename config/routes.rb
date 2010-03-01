Fousa::Application.routes.draw do |map|
  resources :posts, :as => "blog" do
    resources :comments
  end
  resources :sites,   :as => "site"
  resources :archive, :as => "archive"
  resources :tags
  resources :search,  :as => "search"
  resources :scratches
  resources :sessions

  namespace :admin do
    resources :posts
  end

  root :to => "posts#index"

  match "blog" => "posts#index", :as => :blog

  match "about"       => "sites#show",  :as => :about
  match "contact"     => "sites#new",   :as => :contact
  match "services"    => "sites#index", :as => :services

  match "sitemap.xml" => "sites#index", :format => "xml"

  match "cloud" => "tags#index", :as => :cloud

  match "archive/:year/:month" => "archive#index", :as => :archive_by_year_and_month

  match "blog/:permalink" => "posts#show", :as => :permalink

  match "login"  => "sessions#new",      :as => :login
  match "logoff" => "sessions#destroy", :as => :logoff

  match ":controller(/:action(/:id(.:format)))"
end

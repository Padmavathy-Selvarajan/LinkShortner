Rails.application.routes.draw do
  # See how all your routes lay out with "rake routes".
  resources :links, :only => [:create, :new]
  devise_for :users
	authenticated do
	   root to: "links#new", as: :authenticated_root
	end
  # You can have the root of your site routed with "root"
  root 'links#new'
  #named resource
  get '/stats', to: 'links#index', as: 'stats'
  get ':short_url' => 'links#go'
end

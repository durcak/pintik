Rails.application.routes.draw do
  devise_for :users
  resources :pins do
  	# get 'list', to: "pins#list"
  	member do 
  		put 'like', to: "pins#upvote"
      put 'follow', to: "pins#follow"
  		get "comments", to: "pins#comments"
  	end
  end

  get  '/mypins' => 'lists#list', as: :users_pins
  get  '/followed' => 'lists#followed', as: :followed_pins
  # post "/pins/add_comment" => "pins#add_comment", :as => "add_new_comment_to_pins"
  # post 'comments' => 'comments#create', as: "create_comment"

  root "pins#index"
  
  resources :comments, :only => [:create, :destroy]
  # resources :users, :only => [:follow, :unfollow]
  get "/users/:id/follow" => "follows#create", as: "follow_user"
  get "/users/:id/unfollow" => "follows#destroy", as: "unfollow_user"

end

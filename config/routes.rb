Rails.application.routes.draw do
  get 'activities/index'

  devise_for :users
  resources :pins do
  	member do 
  		put 'like', to: "pins#upvote"
      # put 'follow', to: "pins#follow"
      put 'follow', to: "follows#create"
  		get "comments", to: "pins#comments"
  	end
  end

  get  '/mypins' => 'lists#list', as: :users_pins
  get  '/followed' => 'lists#followed', as: :followed_pins
  # post "/pins/add_comment" => "pins#add_comment", :as => "add_new_comment_to_pins"
  # post 'comments' => 'comments#create', as: "create_comment"

  root "pins#index"
  
  resources :comments, :only => [:create, :destroy]
  # get "/users/:id/follow" => "follows#create", as: "follow_user"
  # get "/users/:id/unfollow" => "follows#destroy", as: "unfollow_user"

end

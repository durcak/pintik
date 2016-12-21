Rails.application.routes.draw do
  devise_for :users
  resources :pins do
  	# get 'list', to: "pins#list"
  	member do 
  		put 'like', to: "pins#upvote"
  		get "comments", to: "pins#comments"
  	end
  end

  get  '/mypins' => 'lists#list', as: :users_pins
  # post "/pins/add_comment" => "pins#add_comment", :as => "add_new_comment_to_pins"
  # post 'comments' => 'comments#create', as: "create_comment"

  root "pins#index"
  
  resources :comments, :only => [:create, :destroy]
  # resources :comments#, only: :create
end

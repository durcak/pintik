Rails.application.routes.draw do
  get 'activities/index'

  devise_for :users
  resources :pins do
  	member do 
  		put 'like', to: "pins#upvote"
      put 'follow', to: "follows#create"
  		get "comments", to: "pins#comments"
  	end
  end

  get  '/mypins' => 'lists#list', as: :users_pins
  get  '/users/:id/pins' => 'users#pins', as: :user_pins
  put  '/users/:id/send_request' => 'users#send_request', as: :send_request
  put  '/users/:id/decline_request' => 'users#decline_request', as: :decline_request
  put  '/users/:id/accept_request' => 'users#accept_request', as: :accept_request
  put  '/users/:id/remove_request' => 'users#remove_friend', as: :remove_friend
  get  '/users' => 'users#users', as: :users_list
  get  '/friends' => 'users#friends', as: :friends_list
  get  '/followed' => 'lists#followed', as: :followed_pins


  root "pins#index"
  
  resources :comments, :only => [:create, :destroy]
end

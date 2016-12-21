Rails.application.routes.draw do
  devise_for :users
  resources :pins do
  	# get 'list', to: "pins#list"
  	member do 
  		put 'like', to: "pins#upvote"
  	end
  end

  get  '/mypins' => 'lists#list', as: :users_pins

  root "pins#index"
end

Rails.application.routes.draw do
  devise_for :users
  get 'home/about' => 'homes#about'
  root to: "homes#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :goods do
     resources :good_comments, only: [:create, :destroy]
     resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit,:index, :update]
end
Rails.application.routes.draw do
  get "/search" => "search#search"
  devise_for :users
  get 'home/about' => 'homes#about'
  root to: "homes#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :goods do
     resources :good_comments, only: [:create, :destroy]
     resource :favorites, only: [:create, :destroy]
  end
  # 20210223独自のアクションはresourcesより上に置かないとエラーになる
  get "users/output_my_goods" => "users#output_my_goods"
  resources :users, only: [:show, :edit,:index, :update]
  post "/search" => "search#search"
end

Rails.application.routes.draw do

  get "events/(:date)" => "events#index",
      :constraints => { :date => /\d{4}-\d{2}-\d{2}/ },
      :as => "events_date"
  get 'privacy' => 'home#privacy',  :defaults => { :id => '2' }, as: 'privacy'
  get 'news/:id/edit' => 'news#edit'
  get 'communities/:id/edit' => 'communities#edit'
  get 'news/:id/*anything' => 'news#show', as: 'news_custom'
  get 'communities/:id/*anything' => 'communities#show', as: 'community_custom'
  get 'user/:id/*anything' => 'user#show', as: 'user_custom'
  resources :events
  resources :user, only: [:show]
  resources :communities
  resources :carousels
  resources :pages
   mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  resources :news
  get 'home/index'

  devise_for :users,  :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end

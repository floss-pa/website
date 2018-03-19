Rails.application.routes.draw do

  resources :attendees
  resources :tickets
  resources :ticket_types
  get "events/:id/downloads" => "events#calendar_download", as: 'event_calendar_download'
  get "event/:year/:month/:day" => "events#index", constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ }
  get "event/:year/:month/:day/*anything" => "events#index", constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ }
  get 'privacy' => 'home#privacy',  :defaults => { :id => '2' }, as: 'privacy'
  get 'news/:id/edit' => 'news#edit'
  get 'communities/:id/edit' => 'communities#edit'
  get 'news/:id/*anything' => 'news#show', as: 'news_custom'
  get 'communities/:id/*anything' => 'communities#show', as: 'community_custom'
  get 'user/:id/*anything' => 'user#show', as: 'user_custom'
  resources :events do
    resources :attendees, only: [:index]
  end
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

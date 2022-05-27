Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'pages#search', as: :search
  post '/search', to: 'pages#search'
  post '/custom-marker', to: 'pages#custom_marker', as: 'custom_marker'
  get '/result/', to: 'pages#result', as: :result

  resources :favorites, only: %i[index create destroy]

  resources :markers, only: %i[new create]
end

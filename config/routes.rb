Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'pages#search', as: :search
  post '/search', to: 'pages#search'
  post '/marker-info', to: 'pages#marker_info', as: 'marker_info'
  post '/custom-marker', to: 'pages#custom_marker', as: 'custom_marker'
  patch '/custom-marker', to: 'pages#render_overview'
  get '/result/', to: 'pages#result', as: :result
  delete '/markers/:marker_id/favorites', to: 'favorites#destroy'

  resources :favorites, only: %i[index]

  resources :markers, only: %i[new create] do
    resources :reviews, only: %i[new create]
    resources :favorites, only: :create
  end

  resources :reviews, only: %i[index edit update destroy]
  resources :favorites, only: %i[index edit update]
end

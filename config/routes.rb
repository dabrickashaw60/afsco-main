Rails.application.routes.draw do
  devise_for :users
  get 'home', to: 'home#index', as: 'home'
  root 'home#index'
  get 'map', to: 'home#map', as: 'map'
  resources :appointments
  resources :jobs
  post 'assign_job', to: 'jobs#assign_job'
  delete 'unassign_job', to: 'jobs#unassign_job'
  resources :crews

  get 'installer_calendar', to: 'home#installer_calendar'

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  end

end

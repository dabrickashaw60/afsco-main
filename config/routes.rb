Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'home', to: 'home#index', as: 'home'
  root 'home#index'
  get 'map', to: 'home#map', as: 'map'
  resources :appointments
  resources :jobs
  post 'assign_job', to: 'jobs#assign_job'
  delete 'unassign_job', to: 'jobs#unassign_job'

  get 'installer_calendar', to: 'home#installer_calendar'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
Rails.application.routes.draw do
  devise_for :users

  # Home routes
  get 'home', to: 'home#index', as: 'home'
  root 'home#index'
  get 'map', to: 'home#map', as: 'map'
  
  # Appointment routes
  resources :appointments do
    member do
      post :convert_to_job
    end
  end
  
  # Job routes
  resources :jobs do
    member do
      post :add_file_attachment
      delete 'delete_file_attachment/:file_id', action: :delete_file_attachment, as: :delete_file_attachment
    end
  end
  
  # Job assignment routes
  post 'assign_job', to: 'jobs#assign_job'
  delete 'unassign_job', to: 'jobs#unassign_job'
  
  # Crew routes
  resources :crews

  # Installer calendar route
  get 'installer_calendar', to: 'home#installer_calendar'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Admin namespace routes
  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end

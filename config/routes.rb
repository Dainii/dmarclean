Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :jobs, only: %i[index show]
  resources :feedback_uploads, only: %i[new create]
  resources :mailboxes
  resources :domains, only: %i[index show] do
    resources :feedbacks, only: %i[show]
  end
  get '/ptr/:id', to: 'ptr#show', as: 'ptr_lookup', constraints: { id: /[^\/]+/ }
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  mount MissionControl::Jobs::Engine, at: "/mission_control" if ENV["RAILS_ENV"] == "development"
end

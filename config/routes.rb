Rails.application.routes.draw do
  resources :organizations
  root 'static#home'
  get 'about', to: 'static#about'
  get 'projects-map', to: 'static#projects_map'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: :show
  resources :projects
  resources :states
end

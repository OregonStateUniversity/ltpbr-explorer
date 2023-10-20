Rails.application.routes.draw do
  root 'static#home'
  get 'about', to: 'static#about'
  get 'projects-map', to: 'static#projects_map'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :organizations
  resources :projects do
    resources :affiliations
  end
  resources :states
  resources :users, only: :show

end

Rails.application.routes.draw do

  root 'static#home'
  get 'about', to: 'static#about'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :organizations
  resources :projects do
    get 'map', on: :collection
    resources :affiliations
  end
  resources :states
  resources :users, only: :show

end

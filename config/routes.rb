Rails.application.routes.draw do

  root 'static#home'
  get 'about', to: 'static#about'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :organizations
  resources :projects do
    get 'map', on: :collection
    resources :affiliations, except: [:new, :show]
    resources :cover_photo, only: [:edit, :update], controller: :project_cover_photos
    resources :project_photos, except: :new
  end
  resources :states, only: [:index, :show]
  resources :users, only: :show

end

Rails.application.routes.draw do
  root 'static#home'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: :show
  resources :projects
end

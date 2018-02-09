Rails.application.routes.draw do
  get 'users/show'

  root 'static#home'
  devise_for :users
  resources :projects
end

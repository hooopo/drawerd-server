Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'
  
  resources :projects
  get ':page' => 'stack#show', as: 'stack'
end

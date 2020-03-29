Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'
  
  resources :projects do 
    member do 
      get :render_svg
    end
  end
  get ':page' => 'stack#show', as: 'stack'
end

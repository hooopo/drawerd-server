# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  constraints SubdomainRequired do
    root to: 'projects#index', as: 'subdomain_root'
  end

  root to: "home#index"

  resources :projects do
    member do
      get :render_svg
      get :columns
    end

    resources :tables, only: [:new, :create, :destroy, :edit, :update]
    resources :groups, only: [:new, :create, :destroy]
    resources :relationships, only: [:new, :create, :edit, :update, :destroy]
  end
  post "redirect/go" => "redirect#go"
  get ":page" => "stack#show", as: "stack"
end

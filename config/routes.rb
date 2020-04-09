# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sessions, only: [:new, :create]
  delete "sign_out" => "sessions#destroy", as: :destroy_session
  resources :registrations, only: [:new, :create]
  authenticated :user do
    root to: 'projects#index'
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
  get ":page" => "stack#show", as: "stack"
end

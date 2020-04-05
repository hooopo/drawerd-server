# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: "stack#index"

  resources :projects do
    member do
      get :render_svg
      get :columns
    end

    resources :tables, only: [:new, :create, :destroy, :edit, :update]
    resources :groups, only: [:new, :create, :destroy]
    resources :relationships, only: [:new, :create, :edit, :update]
  end
  get ":page" => "stack#show", as: "stack"
end

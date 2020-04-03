# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: "projects#index"

  resources :projects do
    member do
      get :render_svg
    end

    resources :tables, only: [:new, :create, :destroy, :edit, :update]
    resources :groups, only: [:new, :create, :destroy]
  end
  get ":page" => "stack#show", as: "stack"
end

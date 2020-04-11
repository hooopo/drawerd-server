# frozen_string_literal: true

Rails.application.routes.draw do
  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  delete "sign_out" => "sessions#destroy", as: :destroy_session
  post "redirect/go" => "redirect#go"

  root to: "sessions#new"

  constraints(Subdomain) do
    root to: "projects#index"
    resources :invitations, only: [:new, :create, :destroy]
    resources :projects do
      member do
        get :render_svg
        get :columns
      end

      resources :tables, only: [:new, :create, :destroy, :edit, :update]
      resources :groups, only: [:new, :create, :destroy]
      resources :relationships, only: [:new, :create, :edit, :update, :destroy]
    end
  end
end

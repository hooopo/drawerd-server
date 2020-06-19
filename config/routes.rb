# frozen_string_literal: true

Rails.application.routes.draw do
  resources :admin, only: [:index]
  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  delete "sign_out" => "sessions#destroy", as: :destroy_session
  post "redirect/go" => "redirect#go"
  post "payment_webhook" => "payment#webhook"
  get "home" => "home#index"

  root to: "home#index"

  constraints(Subdomain) do
    root to: "projects#index"
    resources :subscriptions
    resources :invitations, only: [:new, :create, :destroy]
    resources :projects do
      member do
        get :render_svg
        get :render_sql
        get :columns
      end

      resources :tables, only: [:new, :create, :destroy, :edit, :update]
      resources :groups, only: [:new, :create, :destroy, :edit, :update]
      resources :relationships, only: [:new, :create, :edit, :update, :destroy]
    end
  end
end

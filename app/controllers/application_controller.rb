# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :authenticate_user!, :current_user, :user_signed_in?, :default_host, :current_company

  helper_method :default_host

  protected

    def default_host
      Rails.application.routes.default_url_options[:host]
    end

    def authenticate_user!
      unless current_user
        redirect_to root_url, notice: "Login Required"
      end
    end

    def current_user
      @current_user ||= User.where(remember_token: cookies[:remember_token_v2]).first if cookies[:remember_token_v2]
    end

    def current_company
      @company ||= current_user&.company
    end

    def user_signed_in?
      !!current_user
    end

    def redirect_to_subdomain
      return unless user_signed_in? # 2.

      if request.subdomain.blank? # 3.
        if current_company
          redirect_to root_url(subdomain: current_company.subdomain)
        end
      else # 4.
        unless current_company.subdomain == request.subdomain
          redirect_to root_url(subdomain: current_company.subdomain)
        end
      end
    end
end

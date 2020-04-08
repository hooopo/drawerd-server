# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_host
    Rails.application.routes.default_url_options[:host]
  end

  helper_method :default_host

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:subdomain])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :subdomain])
    end

    def redirect_to_subdomain
      return unless user_signed_in? # 2.

      if request.subdomain.blank? # 3.
        if current_user.company
          redirect_to root_url(subdomain: current_user.company.subdomain)
        end
      else # 4.
        unless current_user.company.subdomain == request.subdomain
          redirect_to root_url(subdomain: current_user.company.subdomain)
        end
      end
    end
end

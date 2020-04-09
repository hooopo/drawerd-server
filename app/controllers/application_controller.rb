# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :authenticate_user!, :current_user, :user_signed_in?

  protected

  def authenticate_user!
  end

  def current_user
    User.first
  end

  def user_signed_in?
    true
  end
end

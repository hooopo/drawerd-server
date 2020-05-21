# frozen_string_literal: true

class SessionsController < ApplicationController
  layout "blank"
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :check_subdomain, only: [:create, :destroy]

  def create
    @user = @company.users.where(email: user_params[:email]).first
    if @user && @user.authenticate(user_params[:password])
      if user_params[:remember_me]
        cookies.permanent[:remember_token] = @user.remember_token
      else
        cookies[:remember_token] = @user.remember_token
      end
      redirect_to projects_path
    else
      flash.now[:error] = "Email or password is wrong"
      render "new"
    end
  end

  def destroy
    cookies[:remember_token] = nil
    redirect_to root_path, notice: "Sign out successed"
  end

  def new
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:email, :password, :remember_me)
  end

  def check_subdomain
    unless request.subdomain.present? && Company.where(subdomain: request.subdomain).first
      redirect_to(new_sessions_path, notice: "No Subdomain")
    else
      @company = Company.where(subdomain: request.subdomain).first
    end
  end
end

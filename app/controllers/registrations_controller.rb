# frozen_string_literal: true

class RegistrationsController < ApplicationController
  layout "blank"
  skip_before_action :authenticate_user!

  def new
    @user = User.new
    @user.build_own_company
  end

  def create
    @user = User.new(user_params)
    @user.company = @user.own_company
    if @user.save
      cookies.permanent[:remember_token] = @user.remember_token
      redirect_to root_path, notice: "Sign up successed"
    else
      flash.now[:notice] = "Sign up failed"
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, own_company_attributes: [:id, :subdomain])
  end
end

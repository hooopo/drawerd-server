# frozen_string_literal: true

class RegistrationsController < ApplicationController
  layout "blank"
  skip_before_action :authenticate_user!

  def new
    @user = User.new
    @invitation = Invitation.where(token: params[:token]).first if params[:token]
    if @invitation
      @user.email = @invitation.email
    else
      @user.build_own_company
    end
  end

  def create
    if user_params[:invite_token] && (@invitation = Invitation.where(token: user_params[:invite_token]).first)
      user_params.delete(:own_company_attributes)
      user_params.delete(:invite_token)
    end

    @user = User.new(user_params)

    if @invitation
      @user.own_company = nil
      @user.email = @invitation.email
      @user.company = @invitation.company
    else
      @user.company = @user.own_company
    end
    
    if @user.save
      @invitation.update(invitee: @user) if @invitation
      cookies.permanent[:remember_token] = @user.remember_token
      redirect_to root_path(subdomain: @user.company.subdomain), notice: "Sign up successed"
    else
      flash[:notice] = "Sign up failed"
      if @invitation
        redirect_to new_registration_path(token: @invitation.token)
      else
        redirect_to new_registration_path
      end
    end
  end

  def user_params
    params.require(:user).permit(:invite_token, :email, :password, own_company_attributes: [:id, :subdomain])
  end
end

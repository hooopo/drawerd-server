class RegistrationsController < ApplicationController
  layout 'blank'
  skip_before_action :authenticate_user!

  def new
    @user = User.new
    @user.build_own_company
  end

  def create
    @user = User.new(user_params)
    @user.company = @user.own_company
    if @user.save
      redirect_to '/', notice: 'sign up success'
    else
      flash.now[:notice] = 'sign fail'
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, own_company_attributes: [:id, :subdomain])
  end
end

class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def create
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', notice: 'sign out success!'
  end

  def new
    @user = User.new
  end
end

class RedirectController < ApplicationController
  skip_before_action :authenticate_user!
  def go
    @company = Company.where(subdomain: params[:user][:subdomain]).first
    if @company
      redirect_to new_user_session_url(subdomain: @company.subdomain, only_path: false)
    else
      redirect_to new_user_session_url, notice: 'Subdomain not exist'
    end
  end
end

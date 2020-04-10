# frozen_string_literal: true

class RedirectController < ApplicationController
  skip_before_action :authenticate_user!

  def go
    @company = Company.where(subdomain: params[:company][:subdomain]).first
    if @company
      redirect_to new_session_url(subdomain: @company.subdomain, only_path: false)
    else
      redirect_to new_session_url, notice: "Subdomain Not Exist"
    end
  end
end

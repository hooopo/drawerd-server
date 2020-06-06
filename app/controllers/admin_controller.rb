# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :admin_required

  def index
  end

  def admin_required
    unless current_company.subdomain == "hooopo" || Rails.env.development?
      redirect_to root_url
    end
  end
end

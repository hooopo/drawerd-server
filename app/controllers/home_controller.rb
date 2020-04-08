# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_to_subdomain

  def index
  end
end

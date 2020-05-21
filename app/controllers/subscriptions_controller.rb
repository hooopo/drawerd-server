# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :redirect_to_subdomain

  def new
  end

  def index
    @subscriptions = current_company.subscriptions
  end
end

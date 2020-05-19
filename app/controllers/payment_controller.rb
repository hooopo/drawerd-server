# frozen_string_literal: true

class PaymentController < ApplicationController
  skip_before_action :authenticate_user!

  def webhook
    if params["alert_name"] == "subscription_created"
      user = User.find JSON.parse(params["passthrough"])["user_id"]
      user.subscriptions.create!(company: user.company, event_data: params)
      render text: :ok
    else
    end
  end
end

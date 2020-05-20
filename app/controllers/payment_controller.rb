# frozen_string_literal: true

class PaymentController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def webhook
    data = params.permit!.to_h
    head 400 unless Paddle.verify(data)
    if data["alert_name"] == "subscription_created"
      user = User.find JSON.parse(data["passthrough"])["user_id"]
      user.subscriptions.create!(company: user.company, event_data: data)
      render text: :ok
    else
      render text: :unknown
    end
  end
end

# frozen_string_literal: true

class PaymentController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def webhook
    data = params.except(:controller, :action).permit!.to_h
    if not Paddle.verify(data)
      head 400 
      return 
    end
    if data["alert_name"] == "subscription_created"
      user = User.find JSON.parse(data["passthrough"])["user_id"]
      user.subscriptions.create!(company: user.company, event_data: data)
      render plain: :ok
    else
      render plain: :unknown
    end
  end
end

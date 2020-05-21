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
    user = User.find JSON.parse(data["passthrough"])["user_id"]
    if data["alert_name"] == "subscription_created"
      user.subscriptions.create!(
        company: user.company,
        event_data: data,
        next_bill_date: data["next_bill_date"],
        plan: Plan::TYPES[data["subscription_plan_id"].to_i],
        paddle_subscription_id: data["subscription_id"]
      )
      render plain: :ok
    elsif data["alert_name"] == "subscription_payment_succeeded"
      subscription = user.company.subscriptions.where(paddle_subscription_id: data["subscription_id"]).first
      subscription.purchases.create!(
        user: user,
        company: user.company,
        next_bill_date: data["next_bill_date"],
        payment_method: data["payment_method"],
        event_data: data
      )
      render plain: :ok
    elsif data['alert_name'] == 'subscription_cancelled'

    else
      render plain: :unknown
    end
  end
end

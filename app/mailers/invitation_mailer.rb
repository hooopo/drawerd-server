# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def invite(invitation, url)
    @invitation = invitation
    @url = url
    mail(to: @invitation.email, subject: "Welcome to DrawERD")
  end
end

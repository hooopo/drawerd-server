class InvitationsController < ApplicationController
  before_action :redirect_to_subdomain

  def new
    @invitations = current_user.invitations
    @invitation = current_user.invitations.new
  end

  def create
    @invitation = current_user.invitations.new(invitation_params)
    @invitation.company = current_company
    if @invitation.save
      InvitationMailer.invite(@invitation, new_registration_url(:token => @invitation.token, host: default_host)).deliver
      redirect_to new_invitation_path, notice: 'Invite successed.'
    else
      flash.now[:error] = 'Invite failed.'
      render :new
    end
  end

  def invitation_params
    params.fetch(:invitation, {}).permit(:email)
  end
end

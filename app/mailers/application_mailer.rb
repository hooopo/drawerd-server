# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@drawerd.com"
  layout "mailer"
end

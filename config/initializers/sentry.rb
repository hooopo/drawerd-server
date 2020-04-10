# frozen_string_literal: true

Raven.configure do |config|
  config.dsn = "https://3eeb6e5116d541bb8c826176ef4cbef6:39c7286a81604816b0f1a7176f75793b@o82609.ingest.sentry.io/5191338"
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end

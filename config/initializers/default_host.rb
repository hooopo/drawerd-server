# frozen_string_literal: true

Rails.application.routes.default_url_options[:host] = if Rails.env.development?
  "lvh.me:3000"
elsif Rails.env.test?
  "lvh.me:3000"
elsif Rails.env.production?
  "drawerd.com"
end

# NOTICE: http://lulalala.logdown.com/posts/5835445-rails-many-default-url-options
Rails.application.routes.default_url_options[:protocol] = "https"

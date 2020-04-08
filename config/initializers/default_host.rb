Rails.application.routes.default_url_options[:host] = if Rails.env.development?
  "lvh.me:3000"
elsif Rails.env.test?
  "lvh.me:3000"
elsif Rails.env.production?
  'drawerd.com'
end

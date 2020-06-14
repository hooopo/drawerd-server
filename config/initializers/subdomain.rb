# frozen_string_literal: true

class Subdomain
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != "www"
  end

  def self.main(request)
    "." + request.domain.split(".")[-2..-1].join(".")
  end
end

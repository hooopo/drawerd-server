# frozen_string_literal: true

require "base64"
require "php_serialize"
require "openssl"

class Paddle
  def self.verify(data)
    public_key = <<~KEY
    -----BEGIN PUBLIC KEY-----
    MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwd10YNpmDFL2TCEyPxlO
    aaOc2xdB5WTDa0HON2oe//gswb2M+IqGNHb/9d09R7049cXGZ/EucrJRgHGI56UI
    loGFXEyaNb/VhjruOsBi0UKKNiP2dy7Aejl+SAQ8eyRWe6GcTo0axg6ZJ7MHYcXU
    wwCGPTOfX1uM5l9C7hp7/rPftJDKKVcY0Eo0eyKvTSz56D5iNts57hHHZQMUdrQ0
    4mO/Y54p+0tfZsIA/Qj/2JqeDGqMT+zn6nVaAxRPa1saSU4Uew5vG+2MbDrxkS+g
    CMSCBPGnXvk6BZ0lIslIrvLl1M9PbLXIgTwtZ8pYWv8tydVG0FoiW/6H2pjFeP9V
    cYJPn4Ugu1m0ahTchFRcJF65HEgG2eZpHheOyPrfxrIbZ+hMCJeMYJPEwcAzcUx0
    kYjmmY3fHLEsXF2FkETXHSGPE2sczQJwbJVO6ptq1dV/HsckvOljD187RDUW74Vk
    D0bGucdrXSj8BURKOhzSpfD+dl+ldTstU/0TqjU31vLtUm0d7LLf8EhyrRpArWFa
    99eoccWBmFbdgFZLSQrJRG+H65TCSgz7Pv+ICE4C7S1/3zuczLtTgEL4WVZUYMch
    71WgYTv+FqXRWuWwhj28V6F7TZA3YrgUy/rf1LVrp7tzRlFlClU4hpfBedmbplmG
    2fnFIo0z23vEszV+cab/hC0CAwEAAQ==
    -----END PUBLIC KEY-----
    KEY

    # 'data' represents all of the POST fields sent with the request.
    # Get the p_signature parameter & base64 decode it.
    signature = Base64.decode64(data["p_signature"])

    # Remove the p_signature parameter
    data.delete("p_signature")

    # Ensure all the data fields are strings
    data.each { |key, value|data[key.to_s] = String(value) }

    # Sort the data
    data_sorted = data.sort_by { |key, value| key.to_s }

    # and serialize the fields
    # serialization library is available here: https://github.com/jqr/php-serialize
    data_serialized = PHP.serialize(data_sorted, true)

    # verify the data
    digest    = OpenSSL::Digest::SHA1.new
    binding.pry
    pub_key   = OpenSSL::PKey::RSA.new(public_key).public_key
    verified  = pub_key.verify(digest, signature, data_serialized)
    verified
  end
end

# services/helpers/recaptcha_verifier.rb
# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

# Class responsible for verifying recaptcha of body request
class RecaptchaVerifier
  attr_reader :recaptcha_secret_key

  def initialize(recaptcha_secret_key)
    @recaptcha_secret_key = recaptcha_secret_key
  end

  def verify_recaptcha(recaptcha_response)
    uri = URI.parse('https://www.google.com/recaptcha/api/siteverify')
    http = setup_http_connection(uri)
    params = build_request_params(recaptcha_response)
    request = build_http_request(uri, params)
    response = send_http_request(http, request)
    response_body = parse_response_body(response.body)

    # Access the response data
    score = response_body['score']
    success = response_body['success']

    { score: score, success: success }
  end

  private

  def setup_http_connection(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http
  end

  def build_request_params(recaptcha_response)
    {
      secret: recaptcha_secret_key,
      response: recaptcha_response
    }
  end

  def build_http_request(uri, params)
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(params)
    request
  end

  def send_http_request(http, request)
    http.request(request)
  end

  def parse_response_body(response_body)
    JSON.parse(response_body)
  end
end

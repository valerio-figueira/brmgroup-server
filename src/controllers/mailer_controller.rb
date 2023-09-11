# controllers/mailer_controller.rb
# frozen_string_literal: true

require_relative '../validation/mailer_validator'
require_relative '../services/mailer_service'
require_relative './base_controller'
require_relative '../helpers/logger'
require 'json'

# Class responsible to handle messages for contact
class MailerController < BaseController
  
  def initialize(sinatra_app)
    super(sinatra_app)
    @mailer_service = MailerService.new
  end

  def handle_request
    MailerValidator.new(@params).validate
    @response.status = 200
    @response.headers['Content-Type'] = 'application/json'
    @response.body = @mailer_service.handle_contact_request(@params).to_json
  rescue ArgumentError => e
    CustomLogger.logger.error(e.message)
    # Handle the ArgumentError and send an error response
    @response.status = 400
    @response.headers['Content-Type'] = 'application/json'
    @response.body = { error: e.message }.to_json
  rescue StandardError => e
    CustomLogger.logger.error(e.message)
    # Handle the StandardError and send an error response
    @response.status = 500
    @response.headers['Content-Type'] = 'application/json'
    @response.body = { error: 'Internal Server Error' }.to_json
  end
end

# controllers/curriculum_controller.rb
# frozen_string_literal: true

require_relative '../services/curriculum_service'
require_relative '../validation/curriculum_validator'
require_relative './base_controller'
require_relative '../helpers/logger'
require 'json'

# Class responsible for handling requests.
class CurriculumController < BaseController
  attr_reader :curriculum_service

  def initialize(sinatra_app)
    super(sinatra_app)
    @curriculum_service = CurriculumService.new
  end

  def handle_request
    CurriculumValidator.new(@params).validate
    @response.status = 200
    @response.headers['Content-Type'] = 'application/json'
    @response.body = @curriculum_service.handle_upload(@params).to_json
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

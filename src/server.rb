# app.rb
# frozen_string_literal: true

require 'sinatra/base'
require 'logger'
require 'json'
require_relative './controllers/curriculum_controller'
require_relative './controllers/mailer_controller'
require_relative './helpers/cors'

# Handles server-related functionality.
class Server < Sinatra::Base
  # Define your allowed origins as an array
  ALLOWED_ORIGINS = ['https://groupbrm.com.br', 'http://groupbrm.com.br'].freeze

  # SET CORS MIDDLEWARE
  use CorsMiddleware, ALLOWED_ORIGINS

  configure do
    log_file = File.expand_path('log/error.log', __dir__)
    set :logger, Logger.new(log_file)
    logger.level = Logger::ERROR
    set :show_exceptions, false # Disable default Sinatra error page
  end

  get '/' do
    headers 'Content-Type' => 'application/json'
    { 
      0 => 'Welcome to GROUP BRM - API',
      1 => 'Developed with a touch of artistry, embracing the expressiveness of Ruby.',
      'Author' => 'https://github.com/valerio-figueira'
    }.to_json
  end

  post '/curriculum' do
    CurriculumController.new(self).handle_request
  end

  post '/contact' do
    MailerController.new(self).handle_request
  end
end

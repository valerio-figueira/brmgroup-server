# controllers/base_controller.rb
# frozen_string_literal: true

# Class responsible for handling arguments of sinatra app
class BaseController
  attr_reader :params, :request, :response

  def initialize(sinatra_app)
    @params   = sinatra_app.params
    @request  = sinatra_app.request
    @response = sinatra_app.response
  end
end

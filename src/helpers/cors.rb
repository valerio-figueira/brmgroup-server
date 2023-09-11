# Custom CORS middleware
class CorsMiddleware
  def initialize(app, allowed_origins)
    @app = app
    @allowed_origins = allowed_origins
  end

  def call(env)
    headers = {
      'Access-Control-Allow-Methods' => 'GET, POST',
      'Access-Control-Allow-Headers' => 'Content-Type, Authorization',
      'Access-Control-Allow-Credentials' => 'true'
    }

    origin = env['HTTP_ORIGIN']
    if origin && allowed_origin?(origin)
      headers['Access-Control-Allow-Origin'] = origin
    end

    # Handle preflight requests
    if env['REQUEST_METHOD'] == 'OPTIONS'
      return [200, headers, []]
    end

    # Add CORS headers to every request
    status, response_headers, body = @app.call(env)
    response_headers.merge!(headers)

    [status, response_headers, body]
  end

  private

  def allowed_origin?(origin)
    @allowed_origins.include?(origin)
  end
end
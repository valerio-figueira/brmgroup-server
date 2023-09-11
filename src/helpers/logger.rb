require 'logger'

# Class responsible for handling errors.
class CustomLogger
  def self.logger
    log_file = File.expand_path('../log/error.log', __dir__)
    @logger ||= Logger.new(log_file)
  end
end

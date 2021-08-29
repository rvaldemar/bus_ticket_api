class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def error(status, code, message)
    @http_status = (status.is_a? Symbol) ? Rack::Utils.status_code(status) : status
    @code = code
    @message = message
    return render '/error', status: status
  end
end

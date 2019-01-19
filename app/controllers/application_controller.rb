class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, unless: Proc.new {|c| c.request.format.json? }

  # Rack::MiniProfiler.config.position = 'right' if Rails.env.development?

  def json_request?
    request.format.json?
  end

end

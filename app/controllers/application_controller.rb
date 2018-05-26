class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter do
    response.set_header 'X-Content-Type-Options', 'nosniff'
  end
end

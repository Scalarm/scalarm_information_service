class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.secrets.service_login && password == Rails.application.secrets.service_password
    end
  end
end

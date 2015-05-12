class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private
  def deny_access
    authenticate_or_request_with_http_token do |token, options|
      Agent.find_by(token: token)
    end
  end

end

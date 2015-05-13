class ApplicationController < ActionController::API
  before_action :authenticate

  rescue_from StandardError do |exception|
    render json: { message: "Internal Server Error"}
  end

  def authenticate
    unless request.env.key? "HTTP_AUTHORIZATION"
      return render json: { message: "HTTP_AUTHORIZATION header not found" }
    end

    unless token_authorization = /Token token="(\w{32}+)"/.match(request.env["HTTP_AUTHORIZATION"])
      return render json: { message: "Incompatible HTTP_AUTHORIZATION header" }
    end

    unless @current_agent = Agent.find_by(token: token_authorization[1])
      return render json: { message: "No agent matching with this token" }
    end

    @current_agent
  end

 end

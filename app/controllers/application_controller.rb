class ApplicationController < ActionController::API
  include ActionController::Serialization

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

    unless @current_user = User.find_by(token: token_authorization[1])
      return render json: { message: "No user matching with this token" }
    end

    @current_user
  end

 end

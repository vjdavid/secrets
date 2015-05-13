class ApplicationController < ActionController::API

  def authenticate

    token_authorization = /Token token="(\w{32}+)"/.match(request.env["HTTP_AUTHORIZATION"])
    token_string = token_authorization[1]

    unless token_string
      render json: "No HTTP_AUTHORIZATION or header not found"
    end

    unless @current_agent = Agent.find_by(token: token_string)
      render json: "No agent matching with this token"
    end

    @current_agent
  end

end

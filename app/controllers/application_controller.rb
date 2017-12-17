class ApplicationController < ActionController::API
  before_action :set_raven_context

  def authenticate_user!
    unless request.headers["HTTP_AUTH_UID"].nil? || request.headers["HTTP_AUTH_TOKEN"].nil?
      user = User.find_by(email: request.headers["HTTP_AUTH_UID"])
      @current_user = user if !user.nil? && user.tokens.select {|t| t[:key] == request.headers["HTTP_AUTH_TOKEN"]}.length > 0
    end
    if @current_user.nil?
      render body: nil, status: :forbidden and return
    end
  end

  private
  def set_raven_context
    if Rails.env == 'production'
      Raven.user_context(uid: request.headers["HTTP_AUTH_UID"])
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
  end
end

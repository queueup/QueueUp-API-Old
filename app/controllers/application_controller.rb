# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :set_raven_context
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def authenticate_user!
    unless request.headers['HTTP_AUTH_UID'].nil? || request.headers['HTTP_AUTH_TOKEN'].nil?
      user = User.find_by(email: request.headers['HTTP_AUTH_UID'])
      if !user.nil? && !user.tokens.select {|t| t[:key] == request.headers['HTTP_AUTH_TOKEN'] }.empty?
        @current_user = user
      end
    end
    render(body: nil, status: :forbidden) && return if @current_user.nil?
  end

  private

  def render_404
    render nothing: true, status: :not_found
  end

  def set_raven_context
    return unless Rails.env.production?
    Raven.user_context(uid: request.headers['HTTP_AUTH_UID'])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end

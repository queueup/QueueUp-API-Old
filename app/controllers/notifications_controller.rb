# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @current_user.notifications.pending.update(status: :seen)
    render body: nil
  end
end

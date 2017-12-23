class DevicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @devices = @current_user.devices

    render json: @devices
  end

  def create
    @device = Device.where(device_params).first_or_create do |device|
      device.user = @current_user
    end
    render json: @device
  end

  def destroy
    Device.where(device_params).first_or_create.destroy
    render body: nil
  end

  private
  def device_params
    params.permit(:push_token, :user_token)
  end
end

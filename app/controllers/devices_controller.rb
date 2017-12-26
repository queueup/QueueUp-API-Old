class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:create]

  def index
    @devices = @current_user.devices

    render json: @devices
  end

  def create
    @device.update(user: @current_user)
    render json: @device
  end

  def destroy
    Device.where(push_token: params[:push_token], user_token: params[:user_token]).destroy_all
    render body: nil
  end

  private
  def device_params
    params.require(:device).permit(:push_token, :user_token)
  end

  def set_device
    @device = Device.where(device_params).first_or_create
  end
end

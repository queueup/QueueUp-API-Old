class CommunicationDataController < ApplicationController
  before_action :authenticate_user!
  before_action :set_communication_datum, only: [:show, :update, :destroy]

  def index
    @communication_data = @current_user.communication_data

    render json: @communication_data
  end

  def update
    if @communication_datum.update(communication_datum_params)
      render json: @communication_datum
    else
      render json: @communication_datum.errors, status: :unprocessable_entity
    end
  end

  private
    def set_communication_datum
      @communication_datum = CommunicationDatum.where(user: @current_user, type: params[:id]).first_or_create
    end

    def communication_datum_params
      params.permit(:value)
    end
end

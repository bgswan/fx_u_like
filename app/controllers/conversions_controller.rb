class ConversionsController < ApplicationController

  def index
    @conversion = Conversion.new(query_params)
    @conversion.convert
  end

  def new
    @conversion = Conversion.new
  end

  def create
    @conversion = Conversion.new(conversion_params)
    if @conversion.valid?
      redirect_to conversions_path(@conversion.attributes)
    else
      render :new
    end
  end

  private

  def conversion_params
    permitted(params.require(:conversion))
  end

  def query_params
    permitted(ActionController::Parameters.new(params))
  end

  def permitted(parameters)
    parameters.permit(:rate_at, :amount, :from_ccy, :to_ccy)
  end
end

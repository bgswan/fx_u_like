class ConversionsController < ApplicationController

  def index
    @conversion = Conversion.new(query_params)
    @conversion.convert
    puts "Converted>>>>> #{@conversion.converted_amount}, #{@conversion.attributes}"
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

  def set_conversion
    @conversion = Conversion.new(conversion_params)
  end

  def conversion_params
    params.require(:conversion).permit(:rate_at, :amount, :from_ccy, :to_ccy)
  end

  def query_params
    ActionController::Parameters.new(params).permit(:rate_at, :amount, :from_ccy, :to_ccy)
  end
end

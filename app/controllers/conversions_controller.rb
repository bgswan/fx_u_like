class ConversionsController < ApplicationController

  def new
    @conversion = Conversion.new
  end

  def index
  end

  def create
    redirect_to :conversions
  end
end

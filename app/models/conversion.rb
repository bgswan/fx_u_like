class Conversion

  include ActiveModel::Model
  
  attr_accessor :rate_at, :amount, :from_ccy, :to_ccy
  attr_reader :converted_amount

  def initialize(attributes={})
    super
    @rate_at ||= Date.today
    @amount ||= 100.0
  end
end
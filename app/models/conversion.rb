class Conversion

  include ActiveModel::Model
  include Exchange::Rates
  
  attr_accessor :rate_at, :amount, :from_ccy, :to_ccy
  attr_reader :converted_amount

  validate :conversion_date
  validates :amount, numericality: {greater_than: 0}
  validates :from_ccy, :to_ccy, presence: true

  def initialize(attributes={})
    super
    @rate_at ||= Date.today
    @amount ||= 100.0
    @from_ccy ||= "GBP"
    @to_ccy ||= "GBP"
  end

  def conversion_date
    errors.add(:rate_at, "is not a date") unless rate_at.present? && is_date?(rate_at)
  end

  def convert
    rate = ExchangeRate.at(rate_at, from_ccy, to_ccy)
    @converted_amount = BigDecimal.new(amount.to_s) * rate
    true
  rescue NoRateError => e
    errors.add(:base, e.message)
    false
  end

  def attributes
    {rate_at: rate_at,
     amount: amount,
     from_ccy: from_ccy,
     to_ccy: to_ccy}
  end

  private

  def is_date?(value)
    return true if value.is_a? Date
    Date.parse(value) rescue false
  end
end
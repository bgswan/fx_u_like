class Rate < ActiveRecord::Base

  def self.lookup(date, currency)
    rate = self.where(rate_at: date, currency: currency).first
    raise Exchange::Rates::NoRateError, "No rate for #{currency} at #{date}" if rate.nil?
    rate.rate
  end
end

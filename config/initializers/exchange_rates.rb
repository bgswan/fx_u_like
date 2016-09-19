# Set the local data source for rate data
Exchange::Rates.configure do |config|
  feed_data = File.read(File.join(Rails.root, "feed_data/eurofxref-hist-90d.xml"))
  config.rate_source = Exchange::Rates::EuropeanCentralBankRates.new.parse(feed_data)
end
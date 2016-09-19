require 'test_helper'

class ConversionTest < ActiveSupport::TestCase

  def setup
    Exchange::Rates.configure do |config|
      feed_data = File.read(File.join(Rails.root, "test/fixtures/feed_data.xml"))
      config.rate_source = Exchange::Rates::EuropeanCentralBankRates.new.parse(feed_data)
    end
  end

  test "sets default conversion date and amount" do
    conversion = Conversion.new

    assert_equal Date.today, conversion.rate_at
    assert_equal 100.0, conversion.amount
  end

  test "is created in a valid state" do
    conversion = Conversion.new

    assert conversion.valid?
  end

  test "validates conversion date" do
    conversion = Conversion.new(rate_at: "RUBBISH")

    assert !conversion.valid?
    assert_equal ["is not a date"], conversion.errors[:rate_at]
  end

  test "validates amount" do
    no_amount = Conversion.new
    no_amount.amount = nil

    assert !no_amount.valid?
    assert_equal ["is not a number"], no_amount.errors[:amount]

    less_than_zero = Conversion.new(amount: -1)

    assert !less_than_zero.valid?
    assert_equal ["must be greater than 0"], less_than_zero.errors[:amount]
  end

  test "converts currency" do
    conversion = Conversion.new(rate_at: "2016-09-14", amount: 100.0, from_ccy: "GBP", to_ccy: "USD")

    conversion_result = conversion.convert

    assert_equal true, conversion_result
    assert_equal 150.0, conversion.converted_amount
  end

  test "no rates available for conversion" do
    conversion = Conversion.new(rate_at: "2001-01-01", amount: 100.0, from_ccy: "GBP", to_ccy: "USD")

    conversion_result = conversion.convert

    assert_equal false, conversion_result
    assert_equal ["No rate for GBP at 2001-01-01"], conversion.errors[:base]
  end
end
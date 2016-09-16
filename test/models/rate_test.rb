require 'test_helper'

class RateTest < ActiveSupport::TestCase
  
  test "implements lookup method to use as exchange rate source" do
    assert_equal rates(:usd).rate, Rate.lookup("2016-09-15", "USD")
  end

  test "raises NoRateError when no rate for date or currency" do
    assert_raises Exchange::Rates::NoRateError do
      Rate.lookup("2016-01-01", "JUNK")
    end
  end

end

require 'test_helper'

class ConversionsHelperTest < ActionView::TestCase

  def invalid_amount
    conversion = Conversion.new(amount: "RUBBISH")
    conversion.valid?
    conversion
  end

  def valid_conversion
    conversion = Conversion.new(rate_at: "2016-09-14", amount: 100.0, from_ccy: "GBP", to_ccy: "GBP")
    conversion.convert
    conversion
  end

  def no_rate_conversion
    conversion = Conversion.new(rate_at: "2001-01-01", amount: 100.0, from_ccy: "GBP", to_ccy: "GBP")
    conversion.convert
    conversion
  end

  test "returns error classes for conversion with errors" do
    classes = error_classes_for invalid_amount, :amount
    assert_equal "has-error has-feedback", classes
  end

  test "returns no error classes for valid conversion" do
    classes = error_classes_for Conversion.new, :amount
    assert_nil classes
  end

  test "returns error tags blocks for conversion with error" do
    error_tags = error_text_for invalid_amount, :amount
    assert_includes error_tags, %Q(<span class="help-block">is not a number</span>)
    assert_includes error_tags, %Q(<span class="glyphicon glyphicon-remove form-control-feedback"></span>)
  end

  test "returns no error tags for valid conversion" do
    error_tags = error_text_for Conversion.new, :amount
    assert_nil error_tags
  end

  test "returns conversion result" do
    assert_equal "100.0 GBP = 100.000 GBP on 2016-09-14", conversion_result(valid_conversion)
  end

  test "returns conversion errors for conversion with no rates" do
    assert_equal "No rate for GBP at 2001-01-01", conversion_result(no_rate_conversion)
  end
end
require 'test_helper'

class ConversionsControllerTest < ActionController::TestCase
  
  def valid_conversion_params 
    {rate_at: "2016-09-14", amount: "100.0", from_ccy: "GBP", to_ccy: "GBP"}
  end

  test "get new conversion" do
    get :new
    assert_response :success
    assert_includes @response.body, "FX-u-like"
  end

  test "create invalid conversion" do
    post :create, conversion: {amount: "JUNK"}
    assert_template :new
    assert_includes @response.body, "not a number"
  end

  test "create a valid conversion" do    
    post :create, conversion: valid_conversion_params
    assert_redirected_to conversions_path(valid_conversion_params)
  end

  test "show valid conversion" do
    get :index, valid_conversion_params
    assert_response :success
    assert_includes @response.body, "100.00 GBP = 100.000 GBP on 2016-09-14"
  end

  test "show conversion with no available rates" do
    get :index, valid_conversion_params.merge(from_ccy: "XXX")
    assert_response :success
    assert_includes @response.body, "No rate for XXX at 2016-09-14"
  end
end

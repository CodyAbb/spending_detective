require( 'minitest/autorun' )
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative( '../models/merchant' )

class TestMerchants < MiniTest::Test

  def setup
    @merchant1 = Merchant.new({
      "name" => "Tesco",
      "active" => true
      })

    @merchant2 = Merchant.new({
      "name" => "Chilli Grill",
      "active" => false
      })
  end

  def test_check_availability_true()
    result = @merchant1.availability
    assert_equal("Available", result)
  end

  def test_check_availability_false()
    result = @merchant2.availability
    assert_equal("Currently Unavailable", result)
  end


end

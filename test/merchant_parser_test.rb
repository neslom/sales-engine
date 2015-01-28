require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_parser'

class MerchantParserTest < MiniTest::Test
  def test_it_exists
    assert MerchantParser.new('test/support/merchants.csv')
  end
end

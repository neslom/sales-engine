require_relative 'test_helper'
require_relative '../lib/customer_parser'

class CustomerParserTest < MiniTest::Test
  def test_it_exists
    assert CustomerParser.new('test/support/customers.csv')
  end
end

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_parser'

class CustomerParserTest < MiniTest::Test
  def test_it_exists
    assert CustomerParser.new('test/support/sample_customers.csv')
  end
end
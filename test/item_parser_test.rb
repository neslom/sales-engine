require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_parser'

class ItemParserTest < MiniTest::Test
  def test_it_exists
    assert ItemParser.new('test/support/sample_items.csv')
  end
end

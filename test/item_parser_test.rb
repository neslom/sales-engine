require_relative 'test_helper'
require_relative '../lib/item_parser'

class ItemParserTest < MiniTest::Test
  def test_it_exists
    assert ItemParser.new('test/support/items.csv')
  end
end

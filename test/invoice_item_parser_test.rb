require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'

class InvoiceItemParserTest < MiniTest::Test
  def test_it_exists
    assert InvoiceItemParser.new('test/support/invoice_items.csv')
  end
end

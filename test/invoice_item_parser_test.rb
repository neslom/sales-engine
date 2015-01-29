require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemParserTest < MiniTest::Test
  def test_it_exists
    assert InvoiceItemParser.new('test/support/invoice_items.csv')
  end
end

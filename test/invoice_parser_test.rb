require_relative 'test_helper'
require_relative '../lib/invoice_parser'

class InvoiceParserTest < MiniTest::Test
  def test_it_exists
    assert InvoiceParser.new('test/support/invoices.csv')
  end
end

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_parser'

class InvoiceParserTest < MiniTest::Test
  def test_it_exists
    assert InvoiceParser.new('test/support/sample_invoices.csv')
  end
end

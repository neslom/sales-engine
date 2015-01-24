require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < MiniTest::Test
  attr_reader :parent, :invoice
  def setup
    sales_engine = SalesEngine.new
    @parent = InvoiceRepository.new('test/support/sample_invoices.csv', sales_engine)
    @invoice = Invoice.new({:id => "3", :customer_id => "1", :merchant_id => "78", :status => "shipped", :created_at => "2012-03-10 00:54:09 UTC", :updated_at => "2012-03-10 00:54:09 UTC"},  parent)
  end

  def test_it_exists
    assert invoice
  end

  def test_returns_id_as_integer
    assert_equal 3, invoice.id
  end

  def test_returns_shipped_status
    assert_equal "shipped", invoice.status
  end

  def test_find_all_transactions_by_invoice_id
    result = invoice.find_all_transactions_by_invoice_id(12)
    assert_equal 3, result.size
    refute_equal 5, result.size
  end

  def test_find_all_invoice_items_by_invoice_id
    result = invoice.find_all_invoice_items_by_invoice_id(5)
    assert_equal 4, result.size
    refute_equal 10, result.size
  end

  def test_find_items_by_way_of_invoice_items
    result = invoice.find_item_by_way_of_invoice_items(29)
    assert_equal 8, result.size
  end
end

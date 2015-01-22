require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < MiniTest::Test
  def test_it_exists
    assert Invoice.new({:id => "3"}, nil)
  end

  def test_returns_id_as_integer
    invoice = Invoice.new({:id => "3"}, nil)
    assert_equal 3, invoice.id
  end

  def test_returns_shipped_status
    invoice = Invoice.new({:id => "3", :status => "shipped"}, nil)
    assert_equal "shipped", invoice.status
  end
end

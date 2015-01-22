require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'

class InvoiceItemsTest < MiniTest::Test
  def test_it_exists
    assert InvoiceItems.new({:id => "3"}, nil)
  end

  def test_returns_id_as_integer
    invoice_items = InvoiceItems.new({:id => "3"}, nil)
    assert_equal 3, invoice_items.id
  end

  def test_returns_quantity_as_integer
    invoice_items = InvoiceItems.new({:quantity => "13635"}, nil)
    assert_equal 13635, invoice_items.quantity
  end

  def test_it_formats_unit_price
    invoice_items = InvoiceItems.new({:unit_price => "13635"}, nil)
    assert_equal 136.35, invoice_items.unit_price
  end
end

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'

class InvoiceItemTest < MiniTest::Test
  attr_reader :parent, :invoice_item

  def setup
    sales_engine = SalesEngine.new('test/support')
    @parent = sales_engine.invoice_item_repository
    @invoice_item = InvoiceItem.new({:id =>"8", :item_id => "534", :invoice_id => "1", :quantity => "6", :unit_price => "76941", :created_at => "2012-03-27 14:54:09 UTC" , :updated_at => "2012-03-27 14:54:09 UTC"}, parent)
  end

  def test_it_exists
    assert invoice_item
  end

  def test_returns_id_as_integer
    assert_equal 8, invoice_item.id
  end

  def test_returns_quantity_as_integer
    assert_equal 6, invoice_item.quantity
  end

  def test_it_formats_unit_price
    assert_equal 769.41, invoice_item.unit_price
  end

  def test_find_invoice_by_invoice_item_id
    result = invoice_item.find_invoice_by_invoice_item_id(8)
    assert_equal 1, result.id
    result2 = invoice_item.find_invoice_by_invoice_item_id(28)
    assert_equal 6, result2.id
  end

  def test_find_item_by_invoice_item_id
    result = invoice_item.find_item_by_invoice_item_id(139)
    assert_equal 7, result.id
    assert_equal 311.63, result.unit_price
  end
end

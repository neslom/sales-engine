require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < MiniTest::Test
  attr_reader :parent, :item
  def setup
    sales_engine = SalesEngine.new('test/support')
    @parent = sales_engine.item_repository
    @item = Item.new({:id => "1", :name => "Item Qui Esse", :description => "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", :unit_price => "75107", :merchant_id => "1", :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"},  parent)
  end
  def test_it_exists
    assert item
  end

  def test_returns_id_as_integer
    assert_equal 1, item.id
  end

  def test_returns_name
    assert_equal "Item Qui Esse", item.name
  end

  def test_returns_unit_price
    assert_equal BigDecimal, item.unit_price.class
    assert_equal 751.07, item.unit_price.to_f
  end

  def test_it_returns_zero_for_nil_unit_price
    item = Item.new({:unit_price => nil}, nil)
    assert_equal 0.0, item.unit_price
  end

  def test_find_invoice_items_by_item_id
    result = item.find_invoice_items_by_item_id(6)
    assert_equal 2, result.size
    assert_equal 138, result[0].id
  end

  def test_find_merchant_by_item_id
    result = item.find_merchant_by_item_id(9)
    assert_equal 1, result.id
    result2 = item.find_merchant_by_item_id(99)
    assert_equal 5, result2.id
  end
end

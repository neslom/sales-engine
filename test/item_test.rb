require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < MiniTest::Test
  def test_it_exists
    assert Item.new({:id => "3"}, nil)
  end

  def test_returns_id_as_integer
    item = Item.new({:id => "3"}, nil)
    assert_equal 3, item.id
  end

  def test_returns_name
    item = Item.new({:id => "3", :name => "John"}, nil)
    assert_equal "John", item.name
  end

  def test_returns_unit_price
    item = Item.new({:id => "3", :name => "John", :unit_price => '75107'}, nil)
    assert_equal 751.07, item.unit_price 
  end
end

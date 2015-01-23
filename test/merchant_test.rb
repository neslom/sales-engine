require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < MiniTest::Test
  attr_reader :parent
  def setup
    sales_engine = SalesEngine.new
    @parent = MerchantRepository.new('test/support/sample_merchants.csv', sales_engine)
  end
  def test_it_exists
    assert Merchant.new({:id => "3"}, nil)
  end

  def test_returns_id_as_integer
    merch = Merchant.new({:id => "3"}, nil)
    assert_equal 3, merch.id
  end

  def test_returns_name
    merch = Merchant.new({:id => "3", :name => "John"}, nil)
    assert_equal "John", merch.name
  end

  def test_find_all_items_by_merchant_id
    merch = Merchant.new({:id => "1"}, parent) 
    result = merch.find_all_items_by_merchant_id(1)
    assert_equal 9, result.size
    refute_equal 7, result.size
  end
end

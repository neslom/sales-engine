require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < MiniTest::Test
  attr_reader :parent, :merch
  def setup
    sales_engine = SalesEngine.new
    @parent = MerchantRepository.new('test/support/sample_merchants.csv', sales_engine)
    @merch = Merchant.new({:id => "3", :name => "Willms and Sons", :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"}, parent)
  end
  
  def test_it_exists
    assert merch
  end

  def test_returns_id_as_integer
    assert_equal 3, merch.id
  end

  def test_returns_name
    assert_equal "Willms and Sons", merch.name
  end

  def test_find_all_items_by_merchant_id
    merchant = Merchant.new({:id => "1", :name => "John"}, parent) 
    result = merchant.find_all_items_by_merchant_id(1)
    assert_equal 15, result.size
    refute_equal 7, result.size
    result2 = merch.find_all_items_by_merchant_id(3)
    assert_equal 27, result2.size
  end
end

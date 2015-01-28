require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < MiniTest::Test
  attr_reader :parent, :merch
  def setup
    sales_engine = SalesEngine.new
    @parent = MerchantRepository.new('test/support/merchants.csv', sales_engine)
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
    assert_equal 26, result2.size
  end

  def test_find_all_invoices_by_merchant_id
    merchant = Merchant.new({:id => "99", :name => "John"}, parent)
    result = merchant.find_invoices_by_merchant_id(99)
    assert_equal 2, result.size
    refute_equal 4, result.size
    merchant2 = Merchant.new({:id => "2", :name => "John"}, parent)
    result2 = merchant2.find_invoices_by_merchant_id(2)
    assert_equal 2, result2.size
  end

  #def test_find_transaction_by_way_of_merchant_id
    #skip
    #result = merch.find_total_revenue_by_merchant_id(84)
    #assert_equal 16, result[0].id
    #result2 = merch.find_total_revenue_by_merchant_id(3)
    #assert_equal 95, result2[0].id
  #end

  def test_find_total_revenue_by_merhant_id
    result = merch.find_total_revenue_by_merchant_id(84)
    # invoice_id = 15;
    assert_equal BigDecimal, result.class
    assert_equal 31156.16, result.to_f
  end
end

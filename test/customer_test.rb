require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test
  attr_reader :parent, :customer
  def setup
    sales_engine = SalesEngine.new('test/support')
    parent = sales_engine.customer_repository
    @customer = Customer.new({:id => "3", :first_name => "Mariah", :last_name => "Toy", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC"},  parent)
  end

  def test_it_exists
    assert customer
  end

  def test_returns_id_as_integer
    assert_equal 3, customer.id
  end

  def test_returns_first_name
    assert_equal "Mariah", customer.first_name
  end

  def test_returns_date_object_for_updated_at
    assert_equal DateTime, customer.updated_at.class
  end

  def test_it_finds_all_invoices_by_customer_id
    result = customer.find_all_invoices_by_customer_id(12)
    assert_equal 9, result.size
  end
end

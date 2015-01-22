require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test
  def test_it_exists
    assert Customer.new({:id => "3"}, nil)
  end

  def test_returns_id_as_integer
    customer = Customer.new({:id => "3"}, nil)
    assert_equal 3, customer.id
  end

  def test_returns_first_name
    customer = Customer.new({:id => "3", :first_name => "Cecelia"}, nil)
    assert_equal "Cecelia", customer.first_name
  end

  def test_returns_date_object_for_updated_at
    customer = Customer.new({:updated_at => "2012-03-27 14:54:11 UTC"}, nil)
    assert_equal DateTime, customer.updated_at.class
  end
end

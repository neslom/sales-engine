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
end

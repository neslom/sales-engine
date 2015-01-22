require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test
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
end

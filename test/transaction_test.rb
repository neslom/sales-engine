require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'

class TransactionTest < MiniTest::Test
  def test_it_exists
    assert Transaction.new({:id => "3"}, nil)
  end

  def test_returns_id_as_integer
    trans = Transaction.new({:id => "3"}, nil)
    assert_equal 3, trans.id
  end

  def test_returns_credit_card_number_as_integer
    trans = Transaction.new({:credit_card_number => "4515551623735607"}, nil)
    assert_equal 4515551623735607, trans.credit_card_number
  end
end

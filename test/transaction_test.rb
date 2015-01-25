require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'

class TransactionTest < MiniTest::Test
  attr_reader :parent, :transaction
  def setup
    sales_engine = SalesEngine.new
    @parent = TransactionRepository.new('test/support/sample_transactions.csv', sales_engine)
    @transaction = Transaction.new({:id => "3", :invoice_id => "4", :credit_card_number => "4354495077693036", :credit_card_expiration_date => nil, :result => "success", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC"},  parent)
  end

  def test_it_exists
    assert @transaction
  end

  def test_returns_id_as_integer
    assert_equal 3, @transaction.id
  end

  def test_returns_credit_card_number_as_integer
    assert_equal 4354495077693036, @transaction.credit_card_number
  end

  def test_it_finds_invoice_by_transaction_id
    result = transaction.find_invoice_by_transaciton_id(6)
    assert_equal 7, result.id
  end
end

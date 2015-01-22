require 'minitest/test'
require 'minitest/pride'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < MiniTest::Test
  attr_reader :transaction_repo
  def setup
    @transaction_repo = TransactionRepository.new('test/support/sample_transactions.csv')
  end

  def test_it_parses_csv_file
    first = transaction_repo.transactions.first
    assert_equal 1, first.id
    assert_equal 4654405418249632, first.credit_card_number

    second = transaction_repo.transactions[1]
    assert_equal 2, second.id
    assert_equal 4580251236515201, second.credit_card_number
  end

  def test_all_returns_all_transaction_instances
    merchant_count = transaction_repo.all
    assert_equal 9, merchant_count.size 
  end

  def test_random_returns_random_transaction
    rand = transaction_repo.random
    rand_collection = []
    rand_collection << rand
    assert_equal 1, rand_collection.size
    assert_includes transaction_repo.transactions, rand
  end

  def test_find_by_attribute
    result = transaction_repo.find_by_attribute('invoice_id', 4)
    assert_equal 4, result.invoice_id
    
    result2 = transaction_repo.find_by_attribute('credit_card_number', 4515551623735607)
    assert_equal 4, result2.id
  end

  def test_find_all_by_attribute
    result = transaction_repo.find_all_by_attribute("invoice_id", 2)
    assert_equal 1, result.size 
    
    result2 = transaction_repo.find_all_by_attribute("result", "success")
    assert_equal 9, result2.size
  end
end

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_parser'

class TransactionParserTest < MiniTest::Test
  def test_it_exists
    assert TransactionParser.new('test/support/transactions.csv')
  end
end

require_relative 'test_helper'
require_relative '../lib/transaction_parser'

class TransactionParserTest < MiniTest::Test
  def test_it_exists
    assert TransactionParser.new('test/support/transactions.csv')
  end
end

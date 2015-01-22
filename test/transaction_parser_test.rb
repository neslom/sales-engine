require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_parser'

class TransactionParserTest < MiniTest::Test
  def test_it_exists
    assert TransactionParser.new('test/support/sample_transactions.csv')
  end
end
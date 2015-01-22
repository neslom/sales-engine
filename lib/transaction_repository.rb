require 'csv'
require_relative 'transaction_parser'

class TransactionRepository
  attr_reader :file_name, :transactions
  def initialize(file_name, parent=nil)
    @transactions = [] 
    @parent = parent
    create_transactions(file_name)
  end

  def create_transactions(file_name)
    trans = TransactionParser.new(file_name)
    open_file = trans.read_from_csv
    @transactions = open_file.map { |row| Transaction.new(row, self) }
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_attribute(attribute, match)
    transactions.detect { |transaction| transaction.send(attribute) == match }
  end

  def find_all_by_attribute(attribute, match)
    transactions.select { |transaction| transaction.send(attribute) == match }
  end
end


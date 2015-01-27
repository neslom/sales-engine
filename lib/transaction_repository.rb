require 'csv'
require_relative 'transaction_parser'

class TransactionRepository
  attr_reader :file_name, :transactions, :parent
  def initialize(file_name, parent=SalesEngine.new)
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

  def find_all_transactions_by_invoice_id(id)
    find_all_by_attribute("invoice_id", id)
  end

  def find_invoice_by_transaction_id(id)
    invoice_id = find_by_attribute("id", id).invoice_id
    parent.find_invoice_by_transaction_id(invoice_id)
  end

  def find_total_revenue_by_merchant_id(id)
    if id.map { |invoice_id| find_all_by_attribute("invoice_id", invoice_id) }.flatten.any? { |t| t.result == "success" }
      parent.calculate_revenue(id)
    else
      puts "No revenue!"
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end


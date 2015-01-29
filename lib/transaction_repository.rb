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

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_all_transactions_by_invoice_id(id)
    find_all_by_attribute("invoice_id", id)
  end

  def find_invoice_by_transaction_id(id)
    invoice_id = find_by_attribute("id", id).invoice_id
    parent.find_invoice_by_transaction_id(invoice_id)
  end

  def find_total_revenue_by_merchant_id(id)
    invoice_id = id
    parent.calculate_revenue(transaction_success_checker(invoice_id))
  end

  def transaction_success_checker(invoice_id)
    invoice_id.group_by do |invoice_id|
      find_all_by_attribute("invoice_id", invoice_id).flat_map { |t| t.result == "success" }
    end.delete_if { |k, v| !k.include?(true) }.values.flatten
  end

  def transaction_failure_checker(invoice_id)
    invoice_id.group_by do |invoice_id|
      find_all_by_attribute("invoice_id", invoice_id).flat_map { |t| t.result == "success" }
    end.delete_if { |k, v| k.include?(true) }.values.flatten
  end

  def inspect
    "#<#{self.class} #{transactions.size} rows>"
  end

  def find_all_by_result(result)
    find_all_by_attribute(:result, result)
  end

  def find_by_credit_card_number(id)
    find_by_attribute(:credit_card_number, id)
  end
end

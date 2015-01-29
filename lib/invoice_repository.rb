require 'pry'
require 'csv'
require_relative 'invoice_parser'

class InvoiceRepository
  attr_reader :file_name, :invoices, :parent
  def initialize(file_name, parent=SalesEngine.new)
    @invoices = []
    @parent = parent
    create_invoices(file_name)
  end

  def create_invoices(file_name)
    invoice = InvoiceParser.new(file_name)
    open_file = invoice.read_from_csv
    @invoices = open_file.map { |row| Invoice.new(row, self) }
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_attribute(attribute, match)
    invoices.detect { |invoice| invoice.send(attribute) == match }
  end

  def find_all_by_attribute(attribute, match)
    invoices.select { |invoice| invoice.send(attribute) == match }
  end

  def find_invoices_by_merchant_id(id)
    find_all_by_attribute("merchant_id", id)
  end

  def find_all_transactions_by_invoice_id(id)
    parent.find_all_transactions_by_invoice_id(id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    parent.find_all_invoice_items_by_invoice_id(id)
  end

  def find_item_by_way_of_invoice_items(id)
    parent.find_item_by_way_of_invoice_items(id)
  end

  def find_customer_by_invoice_id(id)
    cust_id = find_by_attribute("id", id).customer_id
    parent.find_customer_by_invoice_id(cust_id)
  end

  def find_merchant_by_invoice_id(id)
    merch_id = find_by_attribute("id", id).merchant_id
    parent.find_merchant_by_invoice_id(merch_id)
  end

  def find_invoice_by_invoice_item_id(id)
    find_by_attribute("id", id)
  end

  def find_invoice_by_transaction_id(id)
    find_by_attribute("id", id)
  end

  def find_all_invoices_by_customer_id(id)
    find_all_by_attribute("customer_id", id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_status(status)
    find_by_attribute("status", status)
  end

  def find_all_by_status(status)
    find_all_by_attribute("status", status)
  end

  def find_by_id(id)
    find_by_attribute("id", id)
  end

  def find_favorite_merchant(merchant_id)
    parent.find_favorite_merchant(merchant_id)
  end
end

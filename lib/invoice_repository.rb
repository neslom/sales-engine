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
end

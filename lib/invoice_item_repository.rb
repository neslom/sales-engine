require 'csv'
require_relative 'invoice_item_parser'

class InvoiceItemRepository
  attr_reader :file_name, :invoice_items, :parent
  def initialize(file_name, parent=SalesEngine.new)
    @invoice_items = [] 
    @parent = parent
    create_invoice_items(file_name)
  end

  def create_invoice_items(file_name)
    invoice_items_parsed = InvoiceItemParser.new(file_name)
    open_file = invoice_items_parsed.read_from_csv
    @invoice_items = open_file.map { |row| InvoiceItems.new(row, self) }
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_attribute(attribute, match)
    invoice_items.detect { |invoice_item| invoice_item.send(attribute) == match }
  end

  def find_all_by_attribute(attribute, match)
    invoice_items.select { |invoice_item| invoice_item.send(attribute) == match }
  end

  def find_all_invoice_items_by_invoice_id(id)
    find_all_by_attribute("invoice_id", id)
  end

  def find_item_by_way_of_invoice_items(id)
    find_all_by_attribute("invoice_id", id) 
  end

  def find_invoice_by_invoice_item_id(id)
    invoice_id = find_by_attribute("id", id).invoice_id
    parent.find_invoice_by_invoice_item_id(invoice_id)
  end
end


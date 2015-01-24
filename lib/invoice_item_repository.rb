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
   # we need to return the objects now by item_id
   find_all_by_attribute("invoice_id", id) 
   # this returns all of the invoice_item objects that we need
   # let's say invoice_id passed in is (1) 
   #    SO, iterate through all invoice items, and select
   #    the item_id each time the invoice_id is (1).
   #   Then with this collection of item_ids, we have to iterate
   #   through Items.csv and return all that match the item_ids
  end
end


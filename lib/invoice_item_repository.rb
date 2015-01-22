require 'csv'
require_relative 'invoice_item_parser'

class InvoiceItemRepository
  attr_reader :file_name, :invoice_items
  def initialize(file_name, parent=nil)
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

  def find_by_item_id(value)
    find_by_attribute("item_id", value)
  end

  def find_all_by_item_id(value)
    find_all_by_attribute("item_id", value)
  end

  def find_by_invoice_id(value)
    find_by_attribute("invoice_id", value)
  end

  def find_all_by_invoice_id(value)
    find_all_by_attribute("invoice_id", value)
  end

   def find_by_quantity(value)
    find_by_attribute("quantity", value)
  end

  def find_all_by_quantity(value)
    find_all_by_attribute("quantity", value)
  end

  def find_by_unit_price(value)
    #need to convert to bignum(USD)
    find_by_attribute("unit_price", value)
  end

  def find_all_by_unit_price(value)
    #need to convert to bignum(USD)
    find_all_by_attribute("unit_price", value)
  end

end


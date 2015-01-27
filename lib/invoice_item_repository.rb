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

  def find_item_by_invoice_item_id(id)
    item_id = find_by_attribute("id", id).item_id
    parent.find_item_by_invoice_item_id(item_id)
  end

  def find_invoice_items_by_item_id(id)
    find_all_by_attribute("item_id", id)
  end

  def calculate_revenue(invoice_id)
    # this is a temporary fix
    #   need to figure out if there can be multiple invoice_ids coming in here
    invoice_id = invoice_id.first.to_i
    find_all_by_attribute("invoice_id", invoice_id).inject(0) do |sum, item|
      sum += (item.unit_price * item.quantity)
      sum
    end
  end
end


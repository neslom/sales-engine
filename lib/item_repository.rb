require 'csv'
require_relative 'item_parser'

class ItemRepository
  attr_reader :file_name, :items, :parent
  def initialize(file_name, parent=SalesEngine.new)
    @items = []
    @parent = parent
    create_items(file_name)
  end

  def create_items(file_name)
    item = ItemParser.new(file_name)
    open_file = item.read_from_csv
    @items = open_file.map { |row| Item.new(row, self) }
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_attribute(attribute, match)
    items.detect { |item| item.send(attribute) == match }
  end

  def find_all_by_attribute(attribute, match)
    items.select { |item| item.send(attribute) == match }
  end

  def find_all_items_by_merchant_id(id)
    find_all_by_attribute("merchant_id", id)
  end

  def find_item_by_way_of_invoice_items(id)
    find_all_by_attribute("id", id)
  end

  def find_item_by_invoice_item_id(id)
    find_by_attribute("id", id)
  end

  def find_invoice_items_by_item_id(id)
    parent.find_invoice_items_by_item_id(id)
  end

  def find_merchant_by_item_id(id)
    merchant_id = find_by_attribute("id", id).merchant_id
    parent.find_merchant_by_item_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

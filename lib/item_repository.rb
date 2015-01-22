require 'csv'
require_relative 'item_parser'

class ItemRepository
  attr_reader :file_name, :items
  def initialize(file_name, parent=nil)
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
end
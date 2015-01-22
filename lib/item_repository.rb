require 'csv'
require './lib/item'

class ItemRepository
  attr_reader :items
  def read_from_csv(file_name='./data/items.csv')
    contents = CSV.open(file_name, headers: true, header_converters: :symbol)
    @items = contents.map { |row| Item.new(row) }
  end
end


item = ItemRepository.new
item.read_from_csv
p item.items.map(&:name)

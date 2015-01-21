require 'csv'
require_relative 'merchant'

class MerchantParser
  def initialize(file_name, parent)
    @file_name = file_name
    @parent = parent  
  end

  def read_from_csv(file_name, parent)
    contents = CSV.open(file_name, headers: true, header_converters: :symbol)
    contents.map { |row| Merchant.new(row, self) }
  end
end

merch = MerchantParser.new
merch.read_from_csv
p merch.merchants.map(&:id)

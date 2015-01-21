require 'csv'
require_relative 'merchant_parser'

class MerchantRepository
  attr_reader :file_name, :merchants
  def initialize(file_name, parent=nil)
    @merchants = [] 
    @parent = parent
    create_merchants(file_name)
  end

  def create_merchants(file_name)
    merch = MerchantParser.new(file_name)
    open_file = merch.read_from_csv
    @merchants = open_file.map { |row| Merchant.new(row, self) }
  end

  def all
    merchants
  end
end

merch = MerchantRepository.new('test/support/sample_merchants.csv')

puts merch.all[0].name

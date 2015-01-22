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

  def random
    merchants.sample
  end

  def find_by_attribute(attribute, match)
    merchants.detect { |merchant| merchant.send(attribute) == match }
  end

  def find_all_by_attribute(attribute, match)
    merchants.select { |merchant| merchant.send(attribute) == match }
  end
end

merch = MerchantRepository.new('test/support/sample_merchants.csv')
p merch.merchants.map(&:created_at)

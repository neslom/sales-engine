require 'csv'
require_relative 'merchant_parser'

class MerchantRepository
  attr_reader :file_name, :merchants, :parent
  def initialize(file_name, parent=SalesEngine.new)
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

  def find_by_name(value)
    find_by_attribute("name", value)
  end

  def find_all_by_name(value)
    find_all_by_attribute("name", value)
  end

  def find_all_items_by_merchant_id(value)
    find_by_attribute("id", value)
    parent.find_all_items_by_merchant_id(value)
  end
end

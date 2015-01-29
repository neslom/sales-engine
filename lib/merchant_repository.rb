require 'pry'
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
    parent.find_all_items_by_merchant_id(value)
  end

  def find_invoices_by_merchant_id(id)
    parent.find_invoices_by_merchant_id(id)
  end

  def find_merchant_by_invoice_id(id)
  find_by_attribute("id", id)
  end

  def find_merchant_by_item_id(id)
  find_by_attribute("id", id)
  end

  def find_total_revenue_by_merchant_id(id, date=nil)
    parent.find_total_revenue_by_merchant_id(id, date)
  end

  def revenue(date=nil)
    parent.find_total_revenue_by_merchant_id(id=nil, date)
  end

  def favorite_customer(id)
    parent.favorite_customer(id)
  end

  def most_revenue(x)
    merchants.sort_by { |merch| find_total_revenue_by_merchant_id(merch.id) }.reverse[0...x]
  end

  def most_items(x)
    merchants.sort_by { |merch| find_all_items_by_merchant_id(merch.id).size }.reverse.
      sort_by { |merch| find_total_revenue_by_merchant_id(merch.id) }.reverse[0...x]
  end

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end
end

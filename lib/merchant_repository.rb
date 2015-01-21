require 'csv'
require_relative 'merchant_parser'

class MerchantRepository
  def initialize(file_name, parent)
    @merchants = []
    @parent = parent
  end

  def create_merchants
    @merchants = MerchantParser.new(file_name, self)
  end
end

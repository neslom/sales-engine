require 'csv'
require './lib/merchant'

class MerchantRepository
  attr_reader :merchants
  def read_from_csv(file_name='./data/merchants.csv')
    contents = CSV.open(file_name, headers: true, header_converters: :symbol)
    @merchants = contents.map { |row| Merchant.new(row) }
  end
end

me = MerchantRepository.new
me.read_from_csv
puts me.merchants

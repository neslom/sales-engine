require 'bigdecimal'

class Item
  attr_reader :id, :name, :parent, :description, :unit_price, :merchant_id, :created_at
  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = (BigDecimal.new(data[:unit_price].to_i) / BigDecimal.new(100)).to_f
    @merchant_id = data[:merchant_id].to_i
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
  end
end

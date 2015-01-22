class Item
  attr_reader :id, :name, :parent
  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at = DateTime.strptime(data[:created_at], "%Y-%m-%d %k:%M:%S UTC")
    @updated_at = DateTime.strptime(data[:updated_at], "%Y-%m-%d %k:%M:%S UTC")
    @parent = parent
  end
end

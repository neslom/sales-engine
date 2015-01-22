class InvoiceItems
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at
  def initialize(data, parent)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = (BigDecimal.new(data[:unit_price].to_i) / BigDecimal.new(100)).to_f
    #@created_at = DateTime.strptime(data[:updated_at], "%Y-%m-%d %k:%M:%S UTC")
    #@updated_at = DateTime.strptime(data[:updated_at], "%Y-%m-%d %k:%M:%S UTC")
    @parent = parent
  end
end


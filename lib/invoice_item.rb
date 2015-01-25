require_relative 'date_formatter'

class InvoiceItems
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :parent
  def initialize(data, parent)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = (BigDecimal.new(data[:unit_price].to_i) / BigDecimal.new(100)).to_f
    @created_at = DateFormatter.format(data[:created_at]) 
    @updated_at = DateFormatter.format(data[:updated_at]) 
    @parent = parent
  end

  # return an instance of Invoice object associated with the invoiceitem id we pass in here
  def find_invoice_by_invoice_item_id(id)
    parent.find_invoice_by_invoice_item_id(id) 
  end 
end


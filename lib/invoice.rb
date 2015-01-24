require_relative 'date_formatter'

class Invoice
  attr_reader :id, :status, :customer_id, :merchant_id, :parent
  def initialize(data, parent)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = DateFormatter.format(data[:created_at])
    @updated_at = DateFormatter.format(data[:updated_at])
    @parent = parent
  end

  def find_all_transactions_by_invoice_id(id)
    parent.find_all_transactions_by_invoice_id(id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    parent.find_all_invoice_items_by_invoice_id(id)
  end
end


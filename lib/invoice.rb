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

  #item search starts here with invoice_id, goes up to item_repository, then up to 
  #  sales engine ( still carrying the invoice_id), we then need to query invoice_items_repo
  #  , but we want to return the item_ids associated with the invoice_ids on each invoice_item
  #   we then pass the item_id value we just grabbed into item_repository and that is our 
  #     final return value
  def find_item_by_way_of_invoice_items(id)
    find_all_invoice_items_by_invoice_id(id).
    
    parent.find_item_by_way_of_invoice_items(id)
  end
end

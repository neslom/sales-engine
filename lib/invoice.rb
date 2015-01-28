require_relative 'date_formatter'
require 'pry'

class Invoice
  attr_reader :id, :status, :customer_id, :merchant_id, :parent, :created_at, :updated_at
  def initialize(data, parent)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = DateFormatter.format(data[:created_at])
    @updated_at = DateFormatter.format(data[:updated_at])
    @parent = parent
  end

  def transactions
    find_all_transactions_by_invoice_id(id)
  end

  def find_all_transactions_by_invoice_id(id)
    parent.find_all_transactions_by_invoice_id(id)
  end

  def items
    find_item_by_way_of_invoice_items(id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    parent.find_all_invoice_items_by_invoice_id(id)
  end

  def find_item_by_way_of_invoice_items(id)
    find_all_invoice_items_by_invoice_id(id).map(&:item_id).map do |item_id|
      parent.find_item_by_way_of_invoice_items(item_id)
    end.flatten
  end

  def find_customer_by_invoice_id(id)
    parent.find_customer_by_invoice_id(id)
  end

  def find_merchant_by_invoice_id(id)
    parent.find_merchant_by_invoice_id(id)
  end

  def customer
    find_customer_by_invoice_id(id)
  end

  def invoice_items
    find_all_invoice_items_by_invoice_id(id)
  end

  def amount
    amount = invoice_items.map(&:total_price)
    amount.inject(:+)
  end
end

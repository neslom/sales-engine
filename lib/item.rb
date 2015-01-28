require 'bigdecimal'
require_relative 'date_formatter'

class Item
  attr_reader :id, :name, :parent, :description, :unit_price, :merchant_id, :created_at
  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price].to_s) / BigDecimal.new(100)
    @merchant_id = data[:merchant_id].to_i
    @created_at = DateFormatter.format(data[:created_at])
    @updated_at = DateFormatter.format(data[:updated_at])
    @parent = parent
  end

  def find_invoice_items_by_item_id(id)
    parent.find_invoice_items_by_item_id(id)
  end

  def find_merchant_by_item_id(id)
    parent.find_merchant_by_item_id(id)
  end

  def invoice_items
    find_invoice_items_by_item_id(id)
  end

  def merchant
    find_merchant_by_item_id(id)
  end

  def best_day
    invoices = invoice_items.map { |inv_item| inv_item.invoice }
    parent.find_best_day_for_item(invoices)
  end

  def total_revenue
    invoice_items.inject(0) do |sum, inv_item| 
      sum + (inv_item.quantity * inv_item.unit_price)
    end
  end
end

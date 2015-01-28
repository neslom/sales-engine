require_relative 'date_formatter'

class Merchant
  attr_reader :id, :name, :parent, :created_at
  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = DateFormatter.format(data[:created_at])
    @updated_at = DateFormatter.format(data[:updated_at])
    @parent = parent
  end

  def find_all_items_by_merchant_id(id)
    parent.find_all_items_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    parent.find_invoices_by_merchant_id(id)
  end

  def find_total_revenue_by_merchant_id(id)
    parent.find_total_revenue_by_merchant_id(id)
  end

  def items
    find_all_items_by_merchant_id(id)
  end

  def invoices
    find_invoices_by_merchant_id(id)
  end
end

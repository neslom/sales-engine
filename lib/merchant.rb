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

  def revenue(date=nil)
    find_total_revenue_by_merchant_id(id, date)
  end

  def find_total_revenue_by_merchant_id(id, date=nil)
    parent.find_total_revenue_by_merchant_id(id, date)
  end

  def items
    find_all_items_by_merchant_id(id)
  end

  def invoices
    find_invoices_by_merchant_id(id)
  end

  def favorite_customer
    parent.favorite_customer(id)
  end

  def failed_customer_transactions
    parent.parent.transaction_repository.transaction_failure_checker(invoices.map(&:id))
  end

  def customers_with_pending_invoices
    failed_customer_transactions.map { |cust| parent.parent.invoice_repository.find_by_attribute("id", cust) }
      .map(&:customer_id).map { |cust| parent.parent.customer_repository.find_by_attribute("id", cust) }
  end
end


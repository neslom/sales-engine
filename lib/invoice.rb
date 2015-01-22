require_relative 'date_formatter'

class Invoice
  attr_reader :id, :status, :customer_id, :merchant_id
  def initialize(data, parent)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = DateFormatter.format(data[:created_at])
    @updated_at = DateFormatter.format(data[:updated_at])
    @parent = parent
  end
end

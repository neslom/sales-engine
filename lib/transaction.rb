require_relative 'date_formatter'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result,
              :created_at, :updated_at, :parent
  def initialize(data, parent)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number].to_i
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result]
    @created_at = DateFormatter.format(data[:created_at])
    @updated_at = DateFormatter.format(data[:updated_at])
    @parent = parent
  end

  def find_invoice_by_transaction_id(id)
    parent.find_invoice_by_transaction_id(id)
  end

  def invoice
    find_invoice_by_transaction_id(id)
  end
end


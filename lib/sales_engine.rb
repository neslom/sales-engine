require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :merchant_repository, :invoice_repository, :item_repository,
  :invoice_item_repository, :customer_repository, :transaction_repository
  
  def initialize(filepath=nil)
    @filepath = filepath
  end

  def startup
    @merchant_repository
    @invoice_repository
    @item_repository
    @invoice_item_repository
    @customer_repository
    @transaction_repository
  end

  def merchant_repository
    @merchant_repository ||= MerchantRepository.new("#{@filepath}/merchants.csv", self)
  end

  def invoice_repository
    @invoice_repository ||= InvoiceRepository.new("#{@filepath}/invoices.csv", self)
  end

  def item_repository
    @item_repository ||= ItemRepository.new("#{@filepath}/items.csv", self)
  end

  def invoice_item_repository
    @invoice_item_repository ||= InvoiceItemRepository.new("#{@filepath}/invoice_items.csv", self)
  end

  def customer_repository
    @customer_repository ||= CustomerRepository.new("#{@filepath}/customers.csv", self)
  end

  def transaction_repository
    @transaction_repository ||= TransactionRepository.new("#{@filepath}/transactions.csv", self)
  end

  def find_all_items_by_merchant_id(id)
    item_repository.find_all_items_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_invoices_by_merchant_id(id)
  end

  def find_all_transactions_by_invoice_id(id)
    transaction_repository.find_all_transactions_by_invoice_id(id)
  end

  def find_all_invoice_items_by_invoice_id(id) # this one
    invoice_item_repository.find_all_invoice_items_by_invoice_id(id)
  end

  def find_item_by_way_of_invoice_items(id)
    item_repository.find_item_by_way_of_invoice_items(id)
  end

  def find_customer_by_invoice_id(id)
    customer_repository.find_customer_by_invoice_id(id)
  end

  def find_merchant_by_invoice_id(id)
    merchant_repository.find_merchant_by_invoice_id(id)
  end

  def find_invoice_by_invoice_item_id(id)
    invoice_repository.find_invoice_by_invoice_item_id(id)
  end

  def find_item_by_invoice_item_id(id)
    item_repository.find_item_by_invoice_item_id(id)
  end

  def find_invoice_by_transaction_id(id)
    invoice_repository.find_invoice_by_transaction_id(id)
  end

  def find_all_invoices_by_customer_id(id)
    invoice_repository.find_all_invoices_by_customer_id(id)
  end

  def find_invoice_items_by_item_id(id)
    # this is an example of an eventual refactoring opportunity
    # invoice_item_repository.find_invoice_items_by_item_id(id)
    invoice_item_repository.find_all_by_attribute("item_id", id)
  end

  def find_merchant_by_item_id(id)
    #merchant_repository.find_by_attribute("id", id)
    merchant_repository.find_merchant_by_item_id(id)
  end

  # below begins calling repository methods from within this class

  def find_total_revenue_by_merchant_id(id, date=nil)
    invoice_id = invoice_repository.find_all_by_attribute("merchant_id", id).map(&:id)
    if date.nil? && !id.nil?
      transaction_repository.find_total_revenue_by_merchant_id(invoice_id)
    elsif !date.nil? && id.nil?
      dated = invoice_repository.find_all_by_attribute("created_at", date).map(&:id)
      transaction_repository.find_total_revenue_by_merchant_id(dated)
    elsif !date.nil? && !id.nil?
      invoice_id = invoice_repository.find_all_by_attribute("merchant_id", id).map(&:id)
      dated = invoice_repository.find_all_by_attribute("created_at", date).map(&:id)
      both = invoice_id & dated
      transaction_repository.find_total_revenue_by_merchant_id(both)
    end
  end

  def calculate_revenue(invoice_id)
    invoice_item_repository.calculate_revenue(invoice_id)
  end

  def find_best_day_for_item(invoices)
    top_invoice_item = invoices.max_by do |invoice|
      invoices.each do |inv|
        if invoice.id == inv.id
          invoice.amount + inv.amount
        else
          invoice.amount
        end
      end
    end
    top_invoice_item.created_at
  end
end

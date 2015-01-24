require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :merchant_repository, :invoice_repository, :item_repository, 
              :invoice_item_repository, :customer_repository, :transaction_repository
  def initialize
    @merchant_repository = MerchantRepository.new('test/support/sample_merchants.csv', self)
    @invoice_repository = InvoiceRepository.new('test/support/sample_invoices.csv', self)
    @item_repository = ItemRepository.new('test/support/sample_items.csv', self)
    @invoice_item_repository = InvoiceItemRepository.new('test/support/sample_invoice_items.csv', self)
    @customer_repository = CustomerRepository.new('test/support/sample_customers.csv', self)
    @transaction_repository = TransactionRepository.new('test/support/sample_transactions.csv', self)
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

  def find_all_invoice_items_by_invoice_id(id)
    invoice_item_repository.find_all_invoice_items_by_invoice_id(id)
  end

  def find_item_by_way_of_invoice_items(id)
     invoice_items = invoice_item_repository.find_item_by_way_of_invoice_items(id)
     # dip down into invoice_item_repo here to grab ALL of the item_ids
     #   for each invoice_item that matches the id we pass in, we need to grab its
     #     item_id. so we'll have multiple item_ids at this point, 
     #        so from here when we dip down into item_repository, we'll have to iterate 
     #        through the items, returning the item for every item_id we're passing in
     invoice_items.map { |invoice item object| IIO.item_id }. 
  end
end


require 'csv'
require_relative 'customer_parser'

class CustomerRepository
  attr_reader :file_name, :customers
  def initialize(file_name, parent=nil)
    @customers = [] 
    @parent = parent
    create_customers(file_name)
  end

  def create_customers(file_name)
    customers_parsed = CustomerParser.new(file_name)
    open_file = customers_parsed.read_from_csv
    @customers = open_file.map { |row| Customer.new(row, self) }
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_attribute(attribute, match)
    customers.detect { |customer| customer.send(attribute) == match }
  end

  def find_all_by_attribute(attribute, match)
    customers.select { |customer| customer.send(attribute) == match }
  end

  #def find_by_first_name(value)
  #find_by_attribute("first_name", value)
  #end

  #def find_all_by_first_name(value)
  #find_all_by_attribute("first_name", value)
  #end

  #def find_by_last_name(value)
  #find_by_attribute("last_name", value)
  #end

  #def find_all_by_last_name(value)
  #find_all_by_attribute("last_name", value)
  #end

  def find_customer_by_invoice_id(id)
    find_by_attribute("id", id)
  end
end

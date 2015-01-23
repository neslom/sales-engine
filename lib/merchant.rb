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

  # needs to call an 'items' method that returns all of the Item instances associated
  # with the merchant's id number that is passed in as an argument
  
  def find_all_items_by_merchant_id(id)
    # calling parent here puts us in the merchant repository
    #   once within the merchant repository we need to find all instances of item
    #   associated with the merchant id, and to do that we have to call a method on the
    #   parent of merchant repository, which is sales engine
    #     once in sales engine, we can access the Item Repository and return all of the
    #     item instances we're looking for
    parent.find_all_items_by_merchant_id(id)
  end 
end

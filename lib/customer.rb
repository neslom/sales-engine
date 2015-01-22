require_relative 'date_formatter'

class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at
  def initialize(data, parent)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = DateFormatter.format(data[:created_at])
    @updated_at = DateFormatter.format(data[:updated_at])
    @parent = parent
  end
end

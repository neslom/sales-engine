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
end

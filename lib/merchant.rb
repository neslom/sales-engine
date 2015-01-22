require 'date'
class Merchant
  attr_reader :id, :name, :parent, :created_at
  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
  end
end

#DateTime.strptime(data[:created_at], "%Y-%m-%d %k:%M:%S UTC")


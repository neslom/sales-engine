class Merchant
  attr_reader :id, :name, :created_at, :updated_at
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @created_at = DateTime.strptime(data[:created_at], "%Y-%m-%d %k:%M:%S UTC")
    @updated_at = DateTime.strptime(data[:updated_at], "%Y-%m-%d %k:%M:%S UTC")
  end
end

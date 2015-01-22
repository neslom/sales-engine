class Merchant
  attr_reader :id, :name, :parent, :created_at
  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    #@created_at = DateTime.strptime(data[:created_at], "%Y-%m-%d %k:%M:%S UTC")
    #@updated_at = DateTime.strptime(data[:updated_at], "%Y-%m-%d %k:%M:%S UTC")
    @parent = parent
  end
end

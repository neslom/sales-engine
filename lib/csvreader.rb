require 'csv'

class CsvReader 
  def self.parse(file)
   CSV.open file, headers: true, header_converters: :symbol 
  end
end

require 'date'

class DateFormatter
  def self.format(date)
    DateTime.strptime(date, "%Y-%m-%d %k:%M:%S UTC") unless date.nil?
  end
end

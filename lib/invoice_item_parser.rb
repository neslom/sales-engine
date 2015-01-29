require 'csv'
require_relative 'invoice_item'

class InvoiceItemParser
	attr_reader :file_name
	def initialize(file_name)
		@file_name = file_name
	end

	def read_from_csv
		CSV.open(file_name, headers: true, header_converters: :symbol)
	end
end

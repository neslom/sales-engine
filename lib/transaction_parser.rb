require 'csv'
require_relative 'transaction'

class TransactionParser
	attr_reader :file_name
	def initialize(file_name)
		@file_name = file_name
	end

	def read_from_csv
		CSV.open(file_name, headers: true, header_converters: :symbol)
	end
end

require 'minitest/test'
require 'minitest/pride'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < MiniTest::Test
  attr_reader :invoice_repo
  def setup
    @invoice_repo = InvoiceRepository.new('test/support/sample_invoices.csv')
  end

  def test_it_parses_csv_file
    first = invoice_repo.invoices.first
    assert_equal 1, first.id
    assert_equal 1, first.customer_id

    second = invoice_repo.invoices[1]
    assert_equal 2, second.id
    assert_equal 75, second.merchant_id
  end

  def test_all_returns_all_invoice_instances
    invoice_count = invoice_repo.all
    assert_equal 99, invoice_count.size 
    refute_equal 9, invoice_count.size
  end

  def test_random_returns_random_invoice
    rand = invoice_repo.random
    rand_collection = []
    rand_collection << rand
    assert_equal 1, rand_collection.size
    assert_includes invoice_repo.invoices, rand
  end

  def test_find_by_attribute
    result = invoice_repo.find_by_attribute('merchant_id', 78)
    assert_equal 3, result.id
    result2 = invoice_repo.find_by_attribute('status', 'shipped')
    assert_equal 1, result2.id
  end

  def test_find_all_by_attribute
    result = invoice_repo.find_all_by_attribute("customer_id", 1)
    assert_equal 8, result.size 
    #result2 = invoice_repo.find_all_by_attribute("created_at", "2012-03-27 14:53:59 UTC")
    #assert_equal 9, result2.size
  end
end

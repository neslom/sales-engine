require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < MiniTest::Test
  attr_reader :invoice_items_repo
  def setup
    @invoice_items_repo = InvoiceItemRepository.new('test/support/invoice_items.csv')
  end

  def test_it_parses_csv_file
    first = invoice_items_repo.invoice_items.first
    assert_equal 1, first.id
    assert_equal 539, first.item_id

    second = invoice_items_repo.invoice_items[1]
    assert_equal 2, second.id
    assert_equal 528, second.item_id
  end

  def test_all_returns_all_invoice_item_instances
    invoice_item_count = invoice_items_repo.all
    assert_equal 107, invoice_item_count.size
  end

  def test_random_returns_random_invoice_item
    rand = invoice_items_repo.random
    rand_collection = []
    rand_collection << rand
    assert_equal 1, rand_collection.size
    assert_includes invoice_items_repo.invoice_items, rand
  end

  def test_find_by_attribute
    result = invoice_items_repo.find_by_attribute("item_id", 535)
    assert_equal 4, result.id

    result2 = invoice_items_repo.find_by_attribute("invoice_id", 1)
    assert_equal 1, result2.id
  end

  def test_find_all_by_attribute
    result = invoice_items_repo.find_all_by_attribute("item_id", 523)
    assert_equal 1, result.size

    result2 = invoice_items_repo.find_all_by_attribute("invoice_id", 1)
    assert_equal 8, result2.size
  end
end

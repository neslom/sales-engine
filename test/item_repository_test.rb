require 'minitest/test'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < MiniTest::Test
  attr_reader :item_repo
  def setup
    @item_repo = ItemRepository.new('test/support/sample_items.csv')
  end

  def test_it_parses_csv_file
    first = item_repo.items.first
    assert_equal 1, first.id
    assert_equal 751.07, first.unit_price

    second = item_repo.items[1]
    assert_equal 2, second.id
    assert_equal 1, second.merchant_id
  end

  def test_all_returns_all_item_instances
    item_count = item_repo.all
    assert_equal 99, item_count.size 
    refute_equal 8, item_count.size
  end

  def test_random_returns_random_invoice
    rand = item_repo.random
    rand_collection = []
    rand_collection << rand
    assert_equal 1, rand_collection.size
    assert_includes item_repo.items, rand
  end

  def test_find_by_attribute
    result = item_repo.find_by_attribute('name', "Item Autem Minima")
    assert_equal 2, result.id
    result2 = item_repo.find_by_attribute('merchant_id', 1)
    assert_equal 1, result2.id
  end

  def test_find_all_by_attribute
    result = item_repo.find_all_by_attribute("merchant_id", 1)
    assert_equal 15, result.size 
    result2 = item_repo.find_all_by_attribute("created_at", "2012-03-27 14:53:59 UTC")
    assert_equal 0, result2.size
  end
end

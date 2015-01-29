require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test
  attr_reader :merchant_repo
  def setup
    @merchant_repo = MerchantRepository.new('test/support/merchants.csv')
  end

  def test_it_parses_csv_file
    first = merchant_repo.merchants.first
    assert_equal 1, first.id
    assert_equal "Schroeder-Jerde", first.name

    second = merchant_repo.merchants[1]
    assert_equal 2, second.id
    assert_equal "Klein, Rempel and Jones", second.name
  end

  def test_all_returns_all_merchant_instances
    merchant_count = merchant_repo.all
    assert_equal 99, merchant_count.size
  end

  def test_random_returns_random_merchant
    rand = merchant_repo.random
    rand_collection = []
    rand_collection << rand
    assert_equal 1, rand_collection.size
    assert_includes merchant_repo.merchants, rand
  end

  def test_find_by_attribute
    result = merchant_repo.find_by_attribute('name', "Hand-Spencer")
    assert_equal "Hand-Spencer", result.name
    result2 = merchant_repo.find_by_attribute('id', 3)
    assert_equal 3, result2.id
  end

  def test_find_all_by_attribute
    result = merchant_repo.find_all_by_attribute("name", "Williamson Group")
    assert_equal 2, result.size
  end
end

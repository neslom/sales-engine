require 'minitest/test'
require 'minitest/pride'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < MiniTest::Test
  attr_reader :customer_repo
  def setup
    @customer_repo = CustomerRepository.new('test/support/sample_customers.csv')
  end

  def test_it_parses_csv_file
    first = customer_repo.customers.first
    assert_equal 1, first.id
    assert_equal "Joey", first.first_name

    second = customer_repo.customers[1]
    assert_equal 2, second.id
    assert_equal "Cecelia", second.first_name
  end

  def test_all_returns_all_merchant_instances
    merchant_count = customer_repo.all
    assert_equal 10, merchant_count.size 
  end

  def test_random_returns_random_customer
    rand = customer_repo.random
    rand_collection = []
    rand_collection << rand
    assert_equal 1, rand_collection.size
    assert_includes customer_repo.customers, rand
  end

  def test_find_by_attribute
    result = customer_repo.find_by_first_name("Joey")
    assert_equal 1, result.id

    result2 = customer_repo.find_by_last_name("Ondricka")
    assert_equal 1, result2.id
  end

  def test_find_all_by_attribute
    result = customer_repo.find_all_by_first_name("Cecelia")
    assert_equal 1, result.size 

    result2 = customer_repo.find_all_by_last_name("Ondricka")
    assert_equal 1, result2.size
  end
end

require 'minitest/test'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test
  attr_reader :merchant_repo
  def setup
    @merchant_repo = MerchantRepository.new('test/support/sample_merchants.csv')
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
    assert_equal 9, merchant_count.size 
  end
end

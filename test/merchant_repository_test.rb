require 'minitest/test'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test
  attr_reader :merchant_repo
  def setup
    @merchant_repo = MerchantRepository.new
  end

  def test_it_exists
    assert merchant_repo
  end

  def test_it_reads_merchant_id
    assert_equal "1", merchant_repo.merchants[0].id
  end
end

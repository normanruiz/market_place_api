require "test_helper"

class ProductTest < ActiveSupport::TestCase

  test 'los precios no pueden ser negativos' do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end
end

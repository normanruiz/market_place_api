require "test_helper"

class ProductTest < ActiveSupport::TestCase

  test 'los precios no pueden ser negativos' do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end

  test 'Filtrar productos por titulo' do
    assert_equal 2, Product.filter_by_title('tv').count
  end

  test 'Filtrar productos por titulo y ordenarlos' do
    assert_equal [products(:three), products(:five) ], Product.filter_by_title('tv').sort
  end

  test 'Filtrar productos por precio >= y ordenarlos' do
    assert_equal [products(:three), products(:four)], Product.above_or_equal_to_price(200).sort
  end

  test 'Filtrar productos por precio <= y ordenarlos' do
    assert_equal [products(:two), products(:one), products(:five)], Product.below_or_equal_to_price(200).sort
  end

  test 'Ordenar los productos por el mas reciente' do
    products(:two).touch
    assert_equal [products(:three), products(:four), products(:one), products(:five), products(:two)], Product.recent.to_a
  end

end

require "test_helper"

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @product = products(:one)
  end

  test 'Devolver un producto' do
    get api_v1_product_url(@product), as: :json
    assert_response :success
    json_response = JSON.parse(self.response.body)
    assert_equal @product.title, json_response['title']
  end

end

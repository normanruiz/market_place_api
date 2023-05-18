require "test_helper"

class Api::V1::TokensControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
  end

  test 'Con datos correctos devolver un token' do
    post api_v1_tokens_url, params: { user: { email: @user.email, password: 'secret_passwd' } }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_not_nil json_response['token']
  end

  test 'Con datos incorrectos no devolver un token' do
    post api_v1_tokens_url, params: { user: { email: 'hacker@al.acecho', password: 'secret_passwd' } }, as: :json
    assert_response :unauthorized
  end

end

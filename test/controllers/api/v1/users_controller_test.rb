require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
  end

  test 'Devolver un usuario con id 1' do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    json_response = JSON.parse(self.response.body)
    assert_equal @user.email, json_response['email']
  end

  test 'Con los datos correctos crear un usuario' do
    assert_difference('User.count') do
      post api_v1_users_url, params: { user: { email: 'user@test.cero', password: 'secret_passwd' } }, as: :json
    end
    assert_response :created
  end

  test 'No se puede duplicar usuarios' do
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { email: @user.email, password: 'secret_passwd' } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test 'Con los datos correctos se puede actualizar un usuario' do
    patch api_v1_user_url(@user), params: { user: { email: @user.email, password: 'secret_passwd' } }, headers: {Authorization: JsonWebToken.encode(user_id: @user.id)}, as: :json
    assert_response :success
  end

  test 'Con los datos incorrectos no se puede actualizar un usuario' do
    patch api_v1_user_url(@user), params: { user: { email: 'usertestcero', password: 'secret_passwd' } }, headers: {Authorization: JsonWebToken.encode(user_id: @user.id)}, as: :json
    assert_response :unprocessable_entity
  end

  test 'Sin autorizacion no actulizar el usuario' do
    patch api_v1_user_url(@user), params: { user: { email: @user.email } }, as: :json
    assert_response :forbidden
  end

  test 'Eliminar un usuario' do
    assert_difference('User.count', -1) do
      delete api_v1_user_url(@user), headers: {Authorization: JsonWebToken.encode(user_id: @user.id)}, as: :json
    end
    assert_response :no_content
  end

  test 'No eliminar un usuario' do
    assert_no_difference('User.count', -1) do
      delete api_v1_user_url(@user), as: :json
    end
    assert_response :forbidden
  end

end

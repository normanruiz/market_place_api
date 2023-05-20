require "test_helper"

class UserTest < ActiveSupport::TestCase

  test 'Un usuario con datos correctos es valido' do
    user = User.new( email: 'user@test.cero', password_digest: 'secret_passwd')
    assert user.valid?
  end

  test 'Un usuario con datos incorrectos es invalido.' do
    user = User.new(email: 'usertestone', password_digest: 'secret_passwd')
    assert_not user.valid?
  end

  test 'Un usuario con datos duplicados es invalido' do
    other_user = users(:one)
    user = User.new(email: other_user.email, password_digest: 'secret_passwd')
    assert_not user.valid?
  end

  test 'Al destruir un usuario destruir tambien sus productos' do
    assert_difference('Product.count', -1) do
      users(:one).destroy
    end
  end

end

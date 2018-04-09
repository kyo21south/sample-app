require 'test_helper'

class SearchUserTest < ActionDispatch::IntegrationTest
  def setup
    @unacti = users(:unacti)
    @michael = users(:michael)
    @archer = users(:archer)
    @malory = users(:malory)
  end

  test "proper user should be appear" do
    # unactivated のユーザーが表示されないようにする
    post users_path, params: { index: { query: "un"} }
    follow_redirect!
    assert_select 'a[href=?]', user_path(@unacti), text: @unacti.name, count: 0
    # あいまい検索が成功しているようにする
    get users_path
    post users_path, params: { index: { query: "archer"} }
    follow_redirect!
    assert_select 'a[href=?]', user_path(@archer), text: @archer.name, count: 1
    assert_select 'a[href=?]', user_path(@malory), text: @malory.name, count: 1
    assert_select 'a[href=?]', user_path(@michael), text: @michael.name, count: 0
  end

end

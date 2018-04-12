require 'test_helper'

class FavTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "favorites page" do
    get favorites_user_path(@user)
    assert_not @user.favorites.empty?
    assert_match @user.favorites.count.to_s, response.body
    @user.favorites.each do |micropost|
      assert_select "a[href=?]", user_path(micropost.user)
    end
  end
end

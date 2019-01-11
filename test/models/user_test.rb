require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"daiki",email:"daiki@baseball.com")
  end

  # test "should be valid" do
  #   assert @user.valid?
  # end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?

  end

  test "password should be present(nonblank)" do
    @user.password =@user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation ="a"
    assert_not @user.valid?
  end
end

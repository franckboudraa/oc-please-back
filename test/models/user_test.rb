require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: "John", last_name: "Doe", email: "user@example.com", password: "123456")
  end

  test "should be valid with all params correctly filled" do
    assert @user.valid?
  end

  test "first_name shouldn't be nil" do
    @user.first_name = nil
    assert @user.invalid?
  end

  test "first_name shouldn't be empty" do
    @user.first_name = ""
    assert @user.invalid?
  end

  test "first_name should not be too long" do
    @user.first_name = "a" * 31
    assert @user.invalid?
  end

  test "last_name shouldn't be nil" do
    @user.last_name = nil
    assert @user.invalid?
  end

  test "last_name shouldn't be empty" do
    @user.last_name = ""
    assert @user.invalid?
  end

  test "last_name should not be too long" do
    @user.last_name = "a" * 31
    assert @user.invalid?
  end

  test "password shouldn't be nil" do
    @user.password = nil
    assert @user.invalid?
  end

  test "password shouldn't be empty" do
    @user.password = " "
    assert @user.invalid?
  end

  test "password should be present (nonblank)" do
    @user.password = " " * 6
    assert @user.invalid?
  end

  test "password should have a minimum length" do
    @user.password = "a" * 5
    assert @user.invalid?
  end

  test "email shouldn't be nil" do
    @user.email = nil
    assert @user.invalid?
  end

  test "email shouldn't be empty" do
    @user.email = ""
    assert @user.invalid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert @user.invalid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert duplicate_user.invalid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end

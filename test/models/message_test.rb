require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = Message.new(
      user_id: 1,
      content: "A message",
      volunteer_id: 1)
  end

  test "should be valid with all params correctly filled" do
    assert @message.valid?
  end

  test "user_id shouldn't be nil" do
    @message.user_id = nil
    assert @message.invalid?
  end

  test "user_id shouldn't be empty" do
    @message.user_id = ""
    assert @message.invalid?
  end

  test "user_id shouldn't be 0" do
    @message.user_id = 0
    assert @message.invalid?
  end

  test "content shouldn't be nil" do
    @message.content = nil
    assert @message.invalid?
  end

  test "content shouldn't be empty" do
    @message.content = ""
    assert @message.invalid?
  end

  test "content shouldn't be too short" do
    @message.content = "a"
    assert @message.invalid?
  end

  test "content shouldn't be too long" do
    @message.content = "a"*256
    assert @message.invalid?
  end

  test "volunteer_id shouldn't be nil" do
    @message.volunteer_id = nil
    assert @message.invalid?
  end

  test "volunteer_id shouldn't be empty" do
    @message.volunteer_id = ""
    assert @message.invalid?
  end

  test "volunteer_id shouldn't be 0" do
    @message.volunteer_id = 0
    assert @message.invalid?
  end
end

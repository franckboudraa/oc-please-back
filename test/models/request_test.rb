require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  def setup
    @request = Request.new(
      title: 'A request title',
      description: 'A request description',
      lat: 1.0,
      lng: 1.0,
      address: 'An address',
      reqtype: :task,
      status: :unfulfilled,
      user_id: 1)
  end

  test "should be valid with all params correctly filled" do
    assert @request.valid?
  end

  test "title shouldn't be nil" do
    @request.title = nil
    assert @request.invalid?
  end

  test "title shouldn't be empty" do
    @request.title = ""
    assert @request.invalid?
  end

  test "title shouldn't be too long" do
    @request.title = "a"*65
    assert @request.invalid?
  end

  test "title shouldn't be too short" do
    @request.title = "a"
    assert @request.invalid?
  end

  test "title shouldn't be present (nonblank)" do
    @request.title = " "*10
    assert @request.invalid?
  end

  test "description shouldn't be nil" do
    @request.description = nil
    assert @request.invalid?
  end

  test "description shouldn't be empty" do
    @request.title = ""
    assert @request.invalid?
  end

  test "lat shouldn't be nil" do
    @request.lat = nil
    assert @request.invalid?
  end

  test "lat shouldn't be empty" do
    @request.lat = ""
    assert @request.invalid?
  end

  test "lng shouldn't be nil" do
    @request.lng = nil
    assert @request.invalid?
  end

  test "lng shouldn't be empty" do
    @request.lng = ""
    assert @request.invalid?
  end

  test "address shouldn't be nil" do
    @request.address = nil
    assert @request.invalid?
  end

  test "address shouldn't be empty" do
    @request.address = ""
    assert @request.invalid?
  end

  test "address shouldn't be too short" do
    @request.address = "a"
    assert @request.invalid?
  end

  test "address shouldn't be too long" do
    @request.address = "a"*256
    assert @request.invalid?
  end

  test "status shouldn't be nil" do
    @request.status = nil
    assert @request.invalid?
  end

  test "status shouldn't be empty" do
    @request.status = ""
    assert @request.invalid?
  end

  test "user_id shouldn't be nil" do
    @request.user_id = nil
    assert @request.invalid?
  end

  test "user_id shouldn't be empty" do
    @request.user_id = ""
    assert @request.invalid?
  end

  test "reqtype shouldn't be nil" do
    @request.reqtype = nil
    assert @request.invalid?
  end

  test "reqtype shouldn't be empty" do
    @request.reqtype = ""
    assert @request.invalid?
  end

end

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  def setup
    @request = Request.new(title: 'A request title', description: 'A request description', lat: 1.0, lng: 1.0, address: 'An address', reqtype: 0, user_id: 1)
  end

  test "should be valid with all params correctly filled" do
    assert @request.valid?
  end
end

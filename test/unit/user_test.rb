require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "next_level" do
    u = users(:one)
    assert u.level == 1
    assert u.next_level == 2

    u.level = 3
    assert u.next_level == 4
  end

  test "has_next_level" do
    u = users(:one)
    assert u.has_next_level

    u.level = 5
    assert !u.has_next_level
  end

end

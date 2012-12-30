require 'test_helper'
require 'pp'

class RankingTest < ActiveSupport::TestCase
  test "add personal" do
    user = User.find(users(:one))
    assert_equal(Ranking.personal_top(user_id: user.id).size, 3, "before add")
    Ranking.add({category: "personal", count: 8, user_id: user.id})
    assert_equal(Ranking.personal_top(user_id: user.id).size, 4, "after add")
    Ranking.add({category: "personal", count: 10, user_id: user.id})
    assert_equal(Ranking.personal_top(user_id: user.id).size, 5, "after add")
    Ranking.add({category: "personal", count: 1, user_id: user.id, limit: 5})
    assert_equal(Ranking.personal_top(user_id: user.id).size, 5, "after add but not inserted because of limit")
  end
end

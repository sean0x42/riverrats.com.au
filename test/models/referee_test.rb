require 'test_helper'

class RefereeTest < ActiveSupport::TestCase
  test "game should be present" do
    referee = Referee.new(player: players(:eve))
    assert_not referee.valid?, 'Referee should not be valid without a game.'
  end
end

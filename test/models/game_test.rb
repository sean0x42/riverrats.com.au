require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "should have at least two players" do
    game = games(:no_players)
    assert_not game.valid?, 'Game should not be valid with less than two players.'
  end

  test "should have at least one referee" do
    game = games(:no_referees)
    assert_not game.valid?, 'Game should not be valid with no referees.'
    # puts game.errors.messages
  end

  test "should not have duplicate players" do
    game = games(:duplicate_players)
    assert_not game.valid?, 'Players should not appear multiple times within one game.'
  end

  test "should not have duplicate referees" do
    game = games(:duplicate_referees)
    assert_not game.valid?, 'Referees should not appear multiple times within one game.'
  end

  test "should be within season" do
    game = games(:out_of_season)
    assert_not game.valid?, 'Game should be played within it\'s season.'
  end
end

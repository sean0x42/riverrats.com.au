require 'test_helper'

class SeasonPlayerTest < ActiveSupport::TestCase
  test "score should be positive" do
    player = players_seasons(:negative_score)
    assert_not player.valid?, 'Season player with negative score should not be valid.'
  end

  test "games played should be positive" do
    player = players_seasons(:negative_games_played)
    assert_not player.valid?, 'Season player with negative games_played should not be valid.'
  end

  test "games won should be positive" do
    player = players_seasons(:negative_games_won)
    assert_not player.valid?, 'Season player with negative games_won should not be valid.'
  end

  test "rank should be positive" do
    player = players_seasons(:negative_rank)
    assert_not player.valid?, 'Season player with negative rank should not be valid.'
  end

  test "player should not be duplicated" do
    PlayersSeason.create(season: seasons(:season_one), player: players(:bob))
    duplicate = PlayersSeason.new(season: seasons(:season_one), player: players(:bob))
    assert_not duplicate.valid?, 'Duplicate season players should not exist.'
  end
end

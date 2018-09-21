require 'test_helper'

class RegionPlayerTest < ActiveSupport::TestCase
  test "score should be positive" do
    player = players_regions(:negative_score)
    assert_not player.valid?, 'Region player with negative score should not be valid.'
  end

  test "games played should be positive" do
    player = players_regions(:negative_games_played)
    assert_not player.valid?, 'Region player with negative games_played should not be valid.'
  end

  test "games won should be positive" do
    player = players_regions(:negative_games_won)
    assert_not player.valid?, 'Region player with negative games_won should not be valid.'
  end

  test "rank should be positive" do
    player = players_regions(:negative_rank)
    assert_not player.valid?, 'Region player with negative rank should not be valid.'
  end

  test "player should not be duplicated" do
    PlayersRegion.create(region: regions(:nabiac), player: players(:bob))
    duplicate = PlayersRegion.new(region: regions(:nabiac), player: players(:bob))
    assert_not duplicate.valid?, 'Duplicate region players should not exist.'
  end
end

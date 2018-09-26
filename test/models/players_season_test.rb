# frozen_string_literal: true

require 'test_helper'

# Tests the join between players and seasons
class PlayersSeasonTest < ActiveSupport::TestCase
  test 'score should be positive' do
    player = players_seasons(:negative_score)
    assert_not player.valid?, 'Season player with negative score.'
  end

  test 'games played should be positive' do
    player = players_seasons(:negative_games_played)
    assert_not player.valid?, 'Season player with negative games_played.'
  end

  test 'games won should be positive' do
    player = players_seasons(:negative_games_won)
    assert_not player.valid?, 'Season player with negative games_won.'
  end

  test 'rank should be positive' do
    player = players_seasons(:negative_rank)
    assert_not player.valid?, 'Season player with negative rank.'
  end

  test 'player should not be duplicated' do
    attrs = { season: seasons(:season_one), player: players(:bob) }
    PlayersSeason.create(attrs)
    duplicate = PlayersSeason.new(attrs)
    assert_not duplicate.valid?, 'Duplicate season players should not exist.'
  end
end

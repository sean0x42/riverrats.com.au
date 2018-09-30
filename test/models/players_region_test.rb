# frozen_string_literal: true

require 'test_helper'

# Tests the join between players and regions
class PlayersRegionTest < ActiveSupport::TestCase
  test 'score should be positive' do
    player = players_regions(:negative_score)
    assert_not player.valid?, 'Region player with negative score.'
  end

  test 'games played should be positive' do
    player = players_regions(:negative_games_played)
    assert_not player.valid?, 'Region player with negative games_played.'
  end

  test 'games won should be positive' do
    player = players_regions(:negative_games_won)
    assert_not player.valid?, 'Region player with negative games_won.'
  end

  test 'player should not be duplicated' do
    attrs = { region: regions(:nabiac), player: players(:bob) }
    PlayersRegion.create(attrs)
    duplicate = PlayersRegion.new(attrs)
    assert_not duplicate.valid?, 'Duplicate region players should not exist.'
  end
end

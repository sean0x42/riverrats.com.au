# frozen_string_literal: true

require 'test_helper'

# Tests the join between players and venues
class PlayersVenueTest < ActiveSupport::TestCase
  test 'score should be positive' do
    player = players_venues(:negative_score)
    assert_not player.valid?, 'Venue player with negative score.'
  end

  test 'games played should be positive' do
    player = players_venues(:negative_games_played)
    assert_not player.valid?, 'Venue player with negative games_played.'
  end

  test 'games won should be positive' do
    player = players_venues(:negative_games_won)
    assert_not player.valid?, 'Venue player with negative games_won.'
  end

  test 'player should not be duplicated' do
    attrs = { venue: venues(:nabiac_hotel), player: players(:bob) }
    PlayersVenue.create(attrs)
    duplicate = PlayersVenue.new(attrs)
    assert_not duplicate.valid?, 'Duplicate venue players should not exist.'
  end
end

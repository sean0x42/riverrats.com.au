require 'test_helper'

class VenuePlayerTest < ActiveSupport::TestCase
  test "score should be positive" do
    player = players_venues(:negative_score)
    assert_not player.valid?, 'Venue player with negative score should not be valid.'
  end

  test "games played should be positive" do
    player = players_venues(:negative_games_played)
    assert_not player.valid?, 'Venue player with negative games_played should not be valid.'
  end

  test "games won should be positive" do
    player = players_venues(:negative_games_won)
    assert_not player.valid?, 'Venue player with negative games_won should not be valid.'
  end

  test "player should not be duplicated" do
    PlayersVenue.create(venue: venues(:nabiac_hotel), player: players(:bob))
    duplicate = PlayersVenue.new(venue: venues(:nabiac_hotel), player: players(:bob))
    assert_not duplicate.valid?, 'Duplicate venue players should not exist.'
  end
end

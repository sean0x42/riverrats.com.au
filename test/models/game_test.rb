# frozen_string_literal: true

require 'test_helper'

# Tests games
class GameTest < ActiveSupport::TestCase
  test 'should have at least two players' do
    game = games(:no_players)
    assert_not game.valid?, 'Game should not have less than two players'
    assert_not_empty game.errors[:games_players],
                     'No validation error given for game with less than two '\
                     'players'
  end

  test 'should have at least one referee' do
    game = games(:no_referees)
    assert_not game.valid?, 'Game should not be valid with no referees'
    assert_not_empty game.errors[:referees],
                     'No validation given for game with no referees'
  end

  test 'should not have duplicate players' do
    game = games(:duplicate_players)
    assert_not game.valid?, 'Players should not appear multiple times'
    assert_not_empty game.errors[:games_players],
                     'No validation error given for game with duplicate players'
  end

  test 'should not have duplicate referees' do
    game = games(:duplicate_referees)
    assert_not game.valid?, 'Referees should not appear multiple times'
    assert_not_empty game.errors[:referees],
                     'No validation error given for game with duplicate '\
                     'referees'
  end

  test 'should be within season' do
    game = games(:out_of_season)
    assert_not game.valid?, 'Game should be played within it\'s season'
    assert_not_empty game.errors[:played_on],
                     'No validation error given for game out of season'
  end
end

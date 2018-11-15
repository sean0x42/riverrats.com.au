# frozen_string_literal: true

require 'test_helper'

# Test games players
class GamePlayerTest < ActiveSupport::TestCase
  test 'position should be positive' do
    player = games_players(:negative_position)
    assert_not player.save, 'Position should be positive.'
  end

  test 'score should be positive' do
    player = games_players(:negative_score)
    assert_not player.save, 'Score should be positive.'
  end
end

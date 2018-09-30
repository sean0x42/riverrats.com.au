# frozen_string_literal: true

require 'test_helper'

# Tests players
class PlayerTest < ActiveSupport::TestCase
  test 'email should be optional' do
    player = players(:carter)
    assert player.valid?, player.errors
  end

  test 'username should be present' do
    blank_username = players(:felicity)
    assert_not blank_username.valid?, 'Player should not be valid with a blank username.'
  end

  test 'first name should be present' do
    blank_first_name = players(:greg)
    assert_not blank_first_name.valid?, 'Player should not be valid with a blank first name.'
  end
end

# frozen_string_literal: true

require 'test_helper'

# Tests players
class PlayerTest < ActiveSupport::TestCase
  test 'valid player' do
    player = players(:carter)
    assert player.valid?, player.errors.messages
  end

  test 'invalid with blank username' do
    player = Player.new(username: '')
    assert_not player.valid?, 'Player is valid without a username'
    assert_not_empty player.errors[:username],
                     'No validation error present for player without a username'
  end

  test 'invalid with blank first name' do
    player = Player.new(first_name: '')
    assert_not player.valid?, 'Player is valid without a first name'
    assert_not_empty player.errors[:first_name],
                     'No validation error present for player without a first '\
                     'name'
  end

  test 'invalid with blank last name' do
    player = Player.new(last_name: '')
    assert_not player.valid?, 'Player is valid without a last name'
    assert_not_empty player.errors[:last_name],
                     'No validation error present for player without a last '\
                     'name'
  end

  test 'invalid with long first name' do
    player = Player.new(first_name: 'a' * 100)
    assert_not player.valid? 'Player is valid with long first name'
    assert_not_empty player.errors[:first_name],
                     'No validation error present for player with long first '\
                     'name'
  end

  test 'invalid with long last name' do
    player = Player.new(last_name: 'a' * 100)
    assert_not player.valid? 'Player is valid with long last name'
    assert_not_empty player.errors[:last_name],
                     'No validation error present for player with long last '\
                     'name'
  end

  test 'invalid with long nickname' do
    player = Player.new(nickname: 'a' * 100)
    assert_not player.valid? 'Player is valid with long nickname'
    assert_not_empty player.errors[:nickname],
                     'No validation error present for player with long '\
                     'nickname'
  end
end

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
    assert_not player.valid?, 'Player is valid with long first name'
    assert_not_empty player.errors[:first_name],
                     'No validation error present for player with long first '\
                     'name'
  end

  test 'invalid with long last name' do
    player = Player.new(last_name: 'a' * 100)
    assert_not player.valid?, 'Player is valid with long last name'
    assert_not_empty player.errors[:last_name],
                     'No validation error present for player with long last '\
                     'name'
  end

  test 'invalid with long nickname' do
    player = Player.new(nickname: 'a' * 100)
    assert_not player.valid?, 'Player is valid with long nickname'
    assert_not_empty player.errors[:nickname],
                     'No validation error present for player with long '\
                     'nickname'
  end

  test 'blank email should be nil' do
    player = Player.new(email: '')
    assert player.email.nil?, 'Email is not made nil when blank'
  end

  test 'blank nickname should be nil' do
    player = Player.new(nickname: '')
    assert player.nickname.nil?, 'Nickname is not made nil when blank'
  end

  test 'First name should be capitalised' do
    error = 'First name was not appropriately capitalised'

    player = Player.new(first_name: 'harry')
    assert player.first_name == 'Harry', error

    player.first_name = 'McKenzie'
    assert player.first_name == 'McKenzie', error
  end

  test 'Last name should be capitalised' do
    error = 'Last name was not appropriately capitalised'

    player = Player.new(last_name: 'smith')
    assert player.last_name == 'Smith', error

    player.last_name = 'McDonald'
    assert player.last_name == 'McDonald', error
  end

  test 'tickets should be clamped above 0' do
    player = Player.new
    player.tickets = -1
    assert player.tickets.zero?, 'Ticket count was not clamped above zero'
  end

  test 'tickets should be an integer' do
    player = Player.new(tickets: 10.5)
    assert_not player.valid?, 'Player is valid with non-integer tickets'
    assert_not_empty player.errors[:tickets],
                     'No validation error present for player with non-integer'\
                     ' tickets'
  end

  test 'password changed should exist' do
    player = Player.new(password_changed: nil)
    assert_not player.valid?, 'Player is valid with nil password changed'
    assert_not_empty player.errors[:password_changed],
                     'No validation error present for player with nil password'\
                     ' changed'
  end

  test 'full name without nickname' do
    player = Player.new(first_name: 'Sean', last_name: 'Bailey')
    assert_equal 'Sean Bailey', player.full_name,
                 'Player name not formatted correctly'

    player.nickname = 'sean0x42'
    assert_equal "Sean 'sean0x42' Bailey", player.full_name,
                 'Player name not formatted correctly'
  end
end

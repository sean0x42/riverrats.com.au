require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "should not save empty player" do
    player = Player.new
    assert_not player.save
  end

  test "should not save username with spaces" do
    player = Player.new(
      username: 'Sean Bailey',
      first_name: 'Sean',
      last_name: 'Bailey',
      email: 'sean@seanbailey.io'
    )

    assert_not player.save
  end
end

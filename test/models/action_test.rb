# frozen_string_literal: true

require 'test_helper'

# Tests actions
class ActionTest < ActiveSupport::TestCase
  test 'description must exist' do
    action = Action.new(description: nil)
    assert_not action.valid?, 'Action is valid without description'
    assert_not_empty action.errors[:description],
                     'No validation error raised with nil description'
  end

  test 'description must not be short' do
    len = 2
    action = Action.new(description: 'a' * len)
    assert_not action.valid?,
               "Action is valid with short description (#{len} chars)"
    assert_not_empty action.errors[:description],
                     'No validation error raised for short description '\
                     "(#{len} chars)"
  end

  test 'description must not be long' do
    len = 141
    action = Action.new(description: 'a' * len)
    assert_not action.valid?,
               "Action is valid with long description (#{len} chars)"
    assert_not_empty action.errors[:description],
                     'No validation error raised for long description '\
                     "(#{len} chars)"
  end

  test 'action must not be nil' do
    action = Action.new(action: nil)
    assert_not action.valid?, 'Action is valid with nil action'
    assert_not_empty action.errors[:action],
                     'No validation error raised for nil action'
  end
end

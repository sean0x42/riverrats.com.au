# frozen_string_literal: true

require 'test_helper'

# Tests the notification model
class NotificationTest < ActiveSupport::TestCase
  test 'invalid with blank message' do
    notification = Notification.new(message: '')
    assert_not notification.valid?, 'Notification was valid with blank message'
    assert_not_empty notification.errors[:message],
                     'No validation error given for blank message'
  end

  test 'invalid with nil message' do
    notification = Notification.new(message: nil)
    assert_not notification.valid?, 'Notification was valid with nil message'
    assert_not_empty notification.errors[:message],
                     'No validation error given for nil message'
  end

  test 'invalid with long message' do
    notification = Notification.new(message: 'o' * 240)
    assert_not notification.valid?,
               'Notification was valid with long message (240 chars)'
    assert_not_empty notification.errors[:message],
                     'No validation error given for long message (240 chars)'
  end

  test 'invalid with short message' do
    notification = Notification.new(message: 'o')
    assert_not notification.valid?,
               'Notification was valid with short message (1 char)'
    assert_not_empty notification.errors[:message],
                     'No validation error given for short message (1 char)'
  end

  test 'invalid with no player' do
    notification = Notification.new(player: nil)
    assert_not notification.valid?, 'Notification valid without player'
    assert_not_empty notification.errors[:player],
                     'No validation error given without player'
  end

  test 'valid without url' do
    notification = Notification.new(url: nil)
    assert_empty notification.errors[:url], 'Validation error given with url'
  end
end

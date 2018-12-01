# frozen_string_literal: true

require 'test_helper'

# Test comments
class CommentTest < ActiveSupport::TestCase
  test 'invalid with blank body' do
    comment = Comment.new(body: '')
    assert_not comment.valid?, 'Comment is valid with blank body'
    assert_not_empty comment.errors[:body],
                     'No validation error present for comment with blank body'
  end

  test 'invalid with nil body' do
    comment = Comment.new(body: nil)
    assert_not comment.valid?, 'Comment is valid with nil body'
    assert_not_empty comment.errors[:body],
                     'No validation error present for comment with nil body'
  end

  test 'invalid with long body' do
    comment = Comment.new(body: 'h' * 500)
    assert_not comment.valid?, 'Comment is valid with long body (500 chars)'
    assert_not_empty comment.errors[:body],
                     'No validation error present for comment with long body '\
                     '(500 chars)'
  end

  test 'invalid without player' do
    comment = Comment.new(player: nil)
    assert_not comment.valid?, 'Comment is valid with nil player'
    assert_not_empty comment.errors[:player],
                     'No validation error present for comment with nil player'
  end

  test 'invalid without game' do
    comment = Comment.new(game: nil)
    assert_not comment.valid?, 'Comment is valid with nil game'
    assert_not_empty comment.errors[:game],
                     'No validation error present for comment with nil game'
  end

  test 'invalid with nil deleted' do
    comment = Comment.new(deleted: nil)
    assert_not comment.valid?, 'Comment is valid with nil deleted'
    assert_not_empty comment.errors[:deleted],
                     'No validation error present for comment with nil deleted'
  end
end

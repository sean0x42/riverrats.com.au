# frozen_string_literal: true

require 'test_helper'

# A test for articles
class ArticleTest < ActiveSupport::TestCase
  test 'title should not be nil' do
    article = Article.new(title: nil)
    assert_not article.valid?, 'Article is valid with nil title'
    assert_not_empty article.errors[:title],
                     'No validation error for article with nil title'
  end

  test 'title should not be blank' do
    article = Article.new(title: '')
    assert_not article.valid?, 'Article is valid with blank title'
    assert_not_empty article.errors[:title],
                     'No validation error for article with blank title'
  end

  test 'title should not be too short' do
    article = Article.new(title: 'a')
    assert_not article.valid?, 'Article is valid with short title (1 char)'
    assert_not_empty article.errors[:title],
                     'No validation error for article with short name (1 char)'
  end

  test 'title should not be too long' do
    article = Article.new(title: 'a' * 400)
    assert_not article.valid?, 'Article is valid with long title (400 chars)'
    assert_not_empty article.errors[:title],
                     'No validation error for article with long name (400 '\
                     'chars)'
  end

  test 'body should not be nil' do
    article = Article.new(body: nil)
    assert_not article.valid?, 'Article is valid with nil body'
    assert_not_empty article.errors[:body],
                     'No validation error for article with nil vody'
  end

  test 'body should not be blank' do
    article = Article.new(body: '')
    assert_not article.valid?, 'Article is valid with blank body'
    assert_not_empty article.errors[:body],
                     'No validation error for article with blank body'
  end

  test 'body should not be too short' do
    article = Article.new(body: 'abc')
    assert_not article.valid?, 'Article is valid with short body (3 chars)'
    assert_not_empty article.errors[:body],
                     'No validation error for article with short body (3 chars)'
  end
end

# frozen_string_literal: true

require 'test_helper'

# Test the venue model
class VenueTest < ActiveSupport::TestCase
  test 'name should not be blank' do
    venue = Venue.new(name: '')
    assert_not venue.valid?, 'Venue should not be valid with a blank name'
    assert_not_empty venue.errors[:name],
                     'No validation error for venue with blank name'
  end

  test 'name should not be nil' do
    venue = Venue.new(name: nil)
    assert_not venue.valid?, 'Venue is valid with nil name'
    assert_not_empty venue.errors[:name],
                     'No validation error for venue with nil name'
  end

  test 'name should be unique' do
    # There is already a venue with this name in fixtures
    venue = Venue.new(name: 'Nabiac Hotel')
    assert_not venue.valid?, 'Venue is valid with non-unique name'
    assert_not_empty venue.errors[:name],
                     'No validation error for venue with non-unique name'
  end

  test 'name should not be long' do
    venue = Venue.new(name: 'a')
    assert_not venue.valid?, 'Venue is valid with short name (1 char)'
    assert_not_empty venue.errors[:name],
                     'No validation error for venue with short name (1 char)'
  end

  test 'name should not be short' do
    venue = Venue.new(name: 'a' * 200)
    assert_not venue.valid?, 'Venue is valid with long name (200 chars)'
    assert_not_empty venue.errors[:name],
                     'No validation error for venue with long name (200 chars)'
  end

  test 'slug should be present' do
    venue = Venue.new(slug: '')
    assert_not venue.valid?, 'Venue should not be valid with a blank slug'
    assert_not_empty venue.errors[:slug],
                     'No validation error for venue with blank slug'
  end

  test 'slug should not be nil' do
    venue = Venue.new(slug: nil)
    assert_not venue.valid?, 'Venue is valid with nil slug'
    assert_not_empty venue.errors[:slug],
                     'No validation error for venue with nil slug'
  end

  test 'region should not be nil' do
    venue = Venue.new(region: nil)
    assert_not venue.valid?, 'Venue is valid without region'
    assert_not_empty venue.errors[:region],
                     'No validation error for venue without region'
  end

  test 'website should be valid url' do
    venue = Venue.new(website: 'a')
    assert_not venue.valid?, 'Venue is valid with invalid URL'
    assert_not_empty venue.errors[:website],
                     'No validation error for invalid URL'
  end
end

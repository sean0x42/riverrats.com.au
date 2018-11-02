# frozen_string_literal: true

require 'test_helper'

# Test the region model
class RegionTest < ActiveSupport::TestCase
  test 'name should not be blank' do
    region = Region.new(name: '')
    assert_not region.valid?, 'Region should not be valid with a blank name'
    assert_not_empty region.errors[:name],
                     'No validation error given for region with blank name'
  end

  test 'slug should not be blank' do
    region = Region.new(slug: '')
    assert_not region.valid?, 'Region should not be valid with a blank slug'
    assert_not_empty region.errors[:slug],
                     'No validation error given for region with blank slug'
  end

  test 'name should not be nil' do
    region = Region.new(name: nil)
    assert_not region.valid?, 'Region should not be valid with a nil name'
    assert_not_empty region.errors[:name],
                     'No validation error given for region with nil name'
  end

  test 'slug should not be nil' do
    region = Region.new(slug: nil)
    assert_not region.valid?, 'Region should not be valid with a nil slug'
    assert_not_empty region.errors[:slug],
                     'No validation error given for region with nil slug'
  end
end

require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  test "name should not be blank" do
    region = Region.new(name: '')
    assert_not region.valid?, 'Region should not be valid with a blank name.'
  end

  test "slug should not be blank" do
    region = Region.new(name: 'Test', slug: '')
    assert_not region.valid?, 'Region should not be valid with a blank slug.'
  end
end

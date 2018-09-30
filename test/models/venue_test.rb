# frozen_string_literal: true

require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  test 'name should be present' do
    venue = Venue.new(name: '', region: regions(:nabiac))
    assert_not venue.valid?, 'Venue should not be valid with a blank name.'
  end

  test 'slug should be present' do
    venue = Venue.new(name: 'Alphabet', slug: '', region: regions(:nabiac))
    assert_not venue.valid?, 'Venue should not be valid with a blank slug.'
  end
end

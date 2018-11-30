# frozen_string_literal: true

require 'test_helper'

# Tests seasons
class SeasonTest < ActiveSupport::TestCase
  test 'start date should be before end date' do
    season = Season.new(
      start_at: Time.zone.today,
      end_at: Time.zone.today - 1.day
    )
    assert_not season.valid?, 'start_at should be before end_at'
  end

  test 'start date should exist' do
    season = Season.new(start_at: nil)
    assert_not season.valid?, 'Season is valid with nil start date'
    assert_not_empty season.errors[:start_at],
                     'No validation error present for season without start date'
  end

  test 'end date should exist' do
    season = Season.new(end_at: nil)
    assert_not season.valid?, 'Season is valid with nil end date'
    assert_not_empty season.errors[:end_at],
                     'No validation error present for season without end date'
  end
end

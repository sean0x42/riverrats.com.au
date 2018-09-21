require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  test "start date should be before end date" do
    season = Season.new(start_at: Time.zone.today, end_at: Time.zone.today - 1.day)
    assert_not season.valid?, 'Season should not be valid if end_at is before start_at.'
  end
end

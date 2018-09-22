require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  test 'start date should be before end date' do
    season = Season.new(
      start_at: Time.zone.today,
      end_at: Time.zone.today - 1.day
    )
    assert_not season.valid?, 'start_at should be before end_at.'
  end
end

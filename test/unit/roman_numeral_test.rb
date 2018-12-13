# frozen_string_literal: true

require 'test_helper'

# Tests roman numeral generation
class RomanNumeralTest < ActiveSupport::TestCase
  test 'the truth' do
    assert_equal 10.to_roman, 'X'
    assert_equal 500.to_roman, 'DM'
    assert_raises(ArgumentError) do
      -5.to_roman
    end
  end
end

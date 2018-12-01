# frozen_string_literal: true

# Coveralls
require 'coveralls'
Coveralls.wear!

require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

# Sidekiq
require 'sidekiq/testing'
Sidekiq::Testing.fake!

# Generic test case, extended by all other cases
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all
end

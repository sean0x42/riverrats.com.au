# frozen_string_literal: true

# Base application record/model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

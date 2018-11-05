# frozen_string_literal: true

# A news/update article
class Article < ApplicationRecord
  with_options presence: true do
    validates :title, uniqueness: true, length: { within: 3..240 }
    validates :body, length: { minimum: 4 }
  end
end

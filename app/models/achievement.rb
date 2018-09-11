# An achievement awarded to a player
class Achievement < ApplicationRecord
  belongs_to :player

  has_attached_file :proof, styles: { full: '1400x1400>' }
  validates_attachment_content_type :proof, content_type: /\Aimage\/.*\z/

  def title
    raise 'System Error: method missing (title)'
  end

  def description
    raise 'System Error: method missing (description)'
  end

  def self.type
    raise 'System Error: method missing (type)'
  end
end

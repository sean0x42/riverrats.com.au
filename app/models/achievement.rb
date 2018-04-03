class Achievement < ApplicationRecord

  belongs_to :player

  has_attached_file :proof, styles: { full: '1400x1400>' }
  validates_attachment_content_type :proof,
                                    content_type: /\Aimage\/.*\z/

  def self.title
    raise 'System Error: method missing (title)'
  end

  def self.description
    raise 'System Error: method missing (description)'
  end

end

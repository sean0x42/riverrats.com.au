class StraightFlush < Achievement

  validates_attachment_presence :proof

  def self.title
    I18n.t('achievement.straight_flush.title')
  end

  def self.description
    I18n.t('achievement.straight_flush.description')
  end

end
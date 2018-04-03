class RoyalFlush < Achievement

  validates_attachment_presence :proof

  def self.title
    I18n.t('achievement.royal_flush.title')
  end

  def self.description
    I18n.t('achievement.royal_flush.description')
  end

end
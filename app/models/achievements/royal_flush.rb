# frozen_string_literal: true

# Awarded to players who are dealt a Royal Flush
class RoyalFlush < Achievement
  validates_attachment_presence :proof

  def self.title
    I18n.t('achievement.royal_flush.title')
  end

  def title
    I18n.t('achievement.royal_flush.title')
  end

  def description
    I18n.t('achievement.royal_flush.description')
  end

  def self.type
    :multi
  end
end

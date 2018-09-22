# frozen_string_literal: true

# Awarded to players that are dealt a Straight Flush
class StraightFlush < Achievement
  validates_attachment_presence :proof

  def self.title
    I18n.t('achievement.straight_flush.title')
  end

  def title
    I18n.t('achievement.straight_flush.title')
  end

  def description
    I18n.t('achievement.straight_flush.description')
  end

  def self.type
    :multi
  end
end
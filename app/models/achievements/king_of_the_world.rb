# frozen_string_literal: true

# Awarded to players who win a regional championship
class KingOfTheWorld < Achievement
  validates_attachment_presence :proof

  def self.title
    I18n.t('achievement.king_of_the_world.title')
  end

  def title
    I18n.t('achievement.king_of_the_world.title')
  end

  def description
    I18n.t('achievement.king_of_the_world.description')
  end

  def self.type
    :multi
  end
end
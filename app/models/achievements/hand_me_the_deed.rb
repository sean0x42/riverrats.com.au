# frozen_string_literal: true

# Awarded to players scoring the most points at a venue
class HandMeTheDeed < Achievement
  def title
    I18n.t('achievement.hand_me_the_deed.title')
  end

  def description
    I18n.t('achievement.hand_me_the_deed.description')
  end

  def self.type
    :multi
  end
end

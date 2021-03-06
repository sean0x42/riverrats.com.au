# frozen_string_literal: true

# Awarded to players who place second in a certain number of games
class TheBridesmaid < Achievement
  def self.check_conditions_for(player)
    awarded = player.awarded? self

    if awarded
      achievement = player.achievements.find_by(type: sti_name)
      achievement.check
    end

    player.award self if !awarded && player.second_places >= requirements[0]

    awarded
  end

  def check
    requirements = self.class.requirements

    # We can go higher
    if requirements.length > level + 1
      # Check conditions
      if player.second_places >= requirements[level + 1]
        player.award self.class, level + 1
      end
    end
  end

  def title
    format(I18n.t('achievement.the_bridesmaid.title'), level: (level + 1).to_roman)
  end

  def description
    games = TheBridesmaid.requirements[level]
    format(I18n.t('achievement.the_bridesmaid.description'), games: "#{games} #{'game'.pluralize games}")
  end

  def self.type
    :single
  end

  def self.requirements
    [1, 10, 25, 50]
  end
end

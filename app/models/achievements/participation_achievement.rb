# frozen_string_literal: true

# Awarded to players who participate in a set number of games
class ParticipationAchievement < Achievement
  def self.check_conditions_for(player)
    awarded = player.awarded? self

    if awarded
      achievement = player.achievements.find_by(type: sti_name)
      achievement.check
    end

    player.award self if !awarded && player.games_played >= requirements[0]
    awarded
  end

  def check
    requirements = self.class.requirements
    return if requirements <= level + 1 ||
              player.games_played < requirements[level + 1]

    player.award self.class, level + 1
  end

  def title
    format(I18n.t('achievement.participation.title'),
           level: (level + 1).to_roman)
  end

  def description
    games = ParticipationAchievement.requirements[level]
    format(I18n.t('achievement.participation.description'),
           count: games, game: 'game'.pluralize(games))
  end

  def self.type
    :single
  end

  def self.requirements
    [1, 5, 10, 25, 50, 100, 250, 500, 750, 1000]
  end
end

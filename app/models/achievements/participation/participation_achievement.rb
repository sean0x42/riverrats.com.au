class ParticipationAchievement < Achievement

  @games = 0
  @level = ''

  ###
  # Checks if a given +player+ satisfies the conditions
  # for the achievement.
  # @param [Player] player to award achievement.
  # @return [Boolean] whether the achievement has already
  #         been awarded.
  def self.check_conditions_for (player)
    awarded = player.awarded? self
    if not awarded and player.games_played > @games
      player.award self
    end
    awarded
  end

  def self.title
    I18n.t('achievement.participation.title') % { level: @level }
  end

  def self.description
    I18n.t('achievement.participation.description') % { count: "#{@games} #{'game'.pluralize @games}" }
  end

end
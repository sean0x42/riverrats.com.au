class ParticipationI < ParticipationAchievement

  @games = 1
  @level = 'I'

  def self.check_conditions_for (player)
    awarded = super
    ParticipationII.check_conditions_for player if awarded
  end

end
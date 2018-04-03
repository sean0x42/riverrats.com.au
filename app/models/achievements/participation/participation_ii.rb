class ParticipationII < ParticipationAchievement

  @games = 5
  @level = 'II'

  def self.check_conditions_for (player)
    awarded = super
    ParticipationIII.check_conditions_for player if awarded
  end

end
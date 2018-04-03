class ParticipationIV < ParticipationAchievement

  @games = 25
  @level = 'IV'

  def self.check_conditions_for (player)
    awarded = super
    ParticipationV.check_conditions_for player if awarded
  end

end
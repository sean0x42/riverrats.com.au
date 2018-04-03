class ParticipationIII < ParticipationAchievement

  @games = 10
  @level = 'III'

  def self.check_conditions_for (player)
    awarded = super
    ParticipationIV.check_conditions_for player if awarded
  end

end
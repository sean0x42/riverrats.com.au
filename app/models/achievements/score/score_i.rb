class ScoreI < ScoreAchievement

  @score = 1000
  @level = 'I'

  def self.check_conditions_for (player)
    awarded = super
    ScoreII.check_conditions_for player if awarded
  end

end
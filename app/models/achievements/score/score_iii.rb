class ScoreIII < ScoreAchievement

  @score = 10000
  @level = 'III'

  def self.check_conditions_for (player)
    awarded = super
    ScoreIV.check_conditions_for player if awarded
  end

end
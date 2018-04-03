class ScoreII < ScoreAchievement

  @score = 5000
  @level = 'II'

  def self.check_conditions_for (player)
    awarded = @level
    ScoreIII.check_conditions_for player if awarded
  end

end
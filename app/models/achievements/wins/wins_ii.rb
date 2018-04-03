class WinsII < WinsAchievement

  @wins = 5
  @level = 'II'

  def self.check_conditions_for (player)
    awarded = super
    WinsIII.check_conditions_for player if awarded
  end

end
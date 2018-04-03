class WinsIII < WinsAchievement

  @wins = 10
  @level = 'III'

  def self.check_conditions_for (player)
    awarded = super
    WinsIV.check_conditions_for player if awarded
  end

end
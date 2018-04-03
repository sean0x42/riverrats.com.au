class WinsIV < WinsAchievement

  @wins = 25
  @level = 'IV'

  def self.check_conditions_for (player)
    awarded = super
    WinsV.check_conditions_for player if awarded
  end

end
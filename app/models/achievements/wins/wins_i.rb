class WinsI < WinsAchievement

  @wins = 1
  @level = 'I'

  def self.check_conditions_for (player)
    awarded = super
    WinsII.check_conditions_for player if awarded
  end

end
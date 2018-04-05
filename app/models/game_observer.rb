class GameObserver < ActiveRecord::Observer

  def after_create (game)

  end

  def after_update (game)
    # Update game scores
    # Update player scores
    # Update venue players
    # Update region players
    # Update season players
    # Check achievements
  end

end
